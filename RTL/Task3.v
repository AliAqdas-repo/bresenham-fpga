module Task3(CLOCK_50, SW , KEY, LEDR,
				VGA_R, VGA_G, VGA_B,
				VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
	input CLOCK_50;	
	input [3:0] KEY;
	input [8:0] SW;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output [9:0] LEDR;
	output VGA_HS;
	output VGA_VS;
	output VGA_BLANK;
	output VGA_SYNC;
	output VGA_CLK;	
	wire reset;

	
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire hold;
	
	circle_draw my_circles(8'd80,7'd60,SW[8:3],x,y,SW[2:0],colour,CLOCK_50,KEY[3],~KEY[0]);
	
	vga_adapter VGA(
			.resetn(KEY[1]),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(1'b1),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_SYNC(VGA_SYNC),
			.VGA_BLANK(VGA_BLANK),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "image.colour.mif";
		defparam VGA.USING_DE1 = "TRUE";
		
endmodule
module circle_draw(xc,yc,rad,x,y,color,color_disp,CLK50,clearn,plot);
	input [7:0]xc;
	input [6:0]yc;
	input [5:0]rad;
	input CLK50,clearn,plot;
	input [2:0] color;
	
	
	
	
	
	output [7:0] x;
	output [6:0] y;
	
	
	output [2:0] color_disp;
	
	wire [7:0] xb,xf;
	wire [6:0] yb,yf;
	wire [5:0] r;
	reg [1:0] nst;
	reg [1:0] pst;
	wire plot;
	
	parameter s0=2'd0,s1=2'd1,s2=2'd2;
	
	wire ofy;
	wire done;
	
	assign r = ((rad > 59) || (rad == 0)) ? 59 : rad;
	blank emp(CLK50,clearn,xb,yb,ofy);
	bresen fill(xc,yc,r,xf,yf,CLK50,(pst == s2),done);
	always @ (pst,ofy,done,plot)
	begin
		case (pst)
		//empty screen
		s0: if(ofy) nst = s1;
			else nst = s0;
		//waiting
		s1: if(plot) nst = s2;
			else nst = s1;
		//plotting
		s2: if(done) nst = s1;
			else nst = s2;
		endcase
	
	end
	
	always @ (posedge CLK50,negedge clearn)
	begin
	
	if(!clearn)
		pst <= s0;
	else 
		pst <= nst;
	end
	
	
	
	assign x = (pst == s0) ? xb : 
				  (pst == s1) ? 80 :
				  xf;
	
	assign y = (pst == s0) ? yb : 
				  (pst == s1) ? 60 :
				  yf;
	assign color_disp = (pst == s2) ? color : 0; 
	
endmodule 