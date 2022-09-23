	module bresen(xc,yc,r,xo,yo,CLK50,plot,done);
	input [7:0]xc;
	input [5:0]r;
	input [6:0]yc;
	input CLK50,plot;
	output [7:0] xo;
	output [6:0] yo;
	output done;
	//output [2:0] pst; //TESTING
	//can be used for TESTING
	wire [10:0] x;
	wire  [7:0] y;
	
	reg signed [7:0] d,dn;
	reg [10:0] xn,xp;
	reg [7:0] yn,yp;
	reg [1:0] nst;
	reg [1:0] pst;
	initial pst = 0;
	reg enplot;
	
	
	parameter Ab=2'b00, Bb=2'b01,Cb=2'b10,Db=2'b11;
	/* ------ TESTING ------
	wire holdn;
	output holdclk;
	assign holdclk = holdn;
	------------------------*/
	setPixel pixplot(xc,yc,x[7:0],y[6:0],xo,yo,CLK50 & enplot,holdn);


	always @(pst,d,x,y,plot,holdn)
	begin
	case(pst)
		//Ready to Draw
	Ab: begin 
		 dn = 3 - (r << 1);
		 xn = 0;
		 yn = {1'b0,r};
		 enplot = 0;
		 if (plot) nst = Cb;
		 else nst = Ab;
		 end
		//Initialzed Drawing
		//Calculating
	Bb: begin
	enplot = 1;
	//if (xp==yp) nst=Ab;
	if (xp>yp) nst = Ab;
		else 
		begin
		nst = Cb;
		xn = xp + 1;
			if (d < 0) dn = d + (xp <<< 2) + 6;
			else
				begin
					dn = d + ((xp-yp) <<< 2) + 10;
					yn = yp - 1;
				end			
	 	end
	end
		//Drawing
	Cb:begin 
	enplot = 1;
		dn = d;
		xn = xp;
		yn = yp;
		if(holdn)
			nst = Bb;
		 else 
			nst = Cb;
		end
	default : nst=Ab;
	endcase
	end
	
	
	always @ (posedge CLK50)
	begin
		begin
		pst <= nst;
		d <= dn;
		xp <= xn;
		yp <= yn;	
		end
	
	end
	
	assign x = (pst == Ab) ?  0 : xp;
	assign y = (pst == Ab) ?  r : yp;
	assign done = (xn > yn);

	
endmodule

module setPixel(xc,yc,x,y,xo,yo,CLK50,holdn);
//module bresen(xc,yc,x,y,xo,yo,CLK50,holdn);
input CLK50;
input [7:0]  xc,x;
input [6:0]  yc,y;

reg [2:0] p_state;
reg [2:0] n_state;
output reg holdn;
output reg [7:0] xo;
output reg [6:0] yo;
parameter A=3'd0,B=3'd1,C=3'd2,D=3'd3,E=3'd4,F=3'd5,G=3'd6,H=3'd7;
 
initial p_state = 0;
always @ (p_state,x,y,xc,yc)
begin
	case(p_state)
	A:
	begin
		xo = xc + x;
		yo = yc + y;
		holdn = 0;
		n_state = B;
	end
	
	B: 
	begin
		xo = xc - x;
		yo = yc + y;
		holdn = 0;
		n_state = C; 
	end
	
	C: 
	begin
		xo = xc + x;
		yo = yc - y;
		holdn = 0;
		n_state = D;
	end
	
	D: 
	begin
		xo = xc - x;
		yo = yc - y;
		holdn = 0;
		n_state = E; 
	end
	
	E: 
	begin
		xo = xc + y;
		yo = yc + x;
		holdn = 0;
		n_state = F; 
	end
	
	F: 
	begin
		xo = xc - y;
		yo = yc + x;
		holdn = 0;
		n_state = G; 
	end
	
	G: 
	begin
		xo = xc + y;
		yo = yc - x;
		holdn = 1;
		n_state = H; 
	end
	
	H: 
	begin
		xo = xc - y;
		yo = yc - x;
		holdn = 0;
		n_state = A;
	end
	endcase
end

always @ (posedge CLK50)
begin
		p_state<=n_state;	
end

endmodule
