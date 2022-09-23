module fill_fsm(clk,reset,x,y,color);
input clk,reset;
output [7:0]x;
output [6:0]y;
output [2:0]color;
wire waste;
wire ofx,ofy;
wire [7:0]cx;
wire [6:0]cy;

counter8b horx(clk,reset,cx,ofx);
counter8b #(120) hory(ofx,reset,{waste,cy},ofy);
assign y = cy;
assign x = cx;
assign color = y % 8;
endmodule 

module blank(clk,reset,x,y,clr_f);
input clk,reset;
output [7:0]x;
output [6:0]y;
output clr_f;
wire waste;
wire ofx,ofy;
wire [7:0]cx;
wire [6:0]cy;

counter8b horx(clk,reset,cx,ofx);
counter8b #(120) hory(ofx,reset,{waste,cy},ofy);
assign y = cy;
assign x = cx;
assign clr_f = ofy;
endmodule 


module counter8b #(parameter carret=160)(clk,reset,count,oflow);

input clk,reset;
output reg oflow;
output reg [7:0] count;
initial 
begin
count = 0;
end

always @ (posedge clk, negedge reset)
begin 
	if (!reset)
		begin
		count <=0;
		oflow <=0;
		end
	else if(count>=carret-1)
		begin
		count  <= 0;
		oflow <=1;
		end
	else
		begin
		oflow  <= 0;
		count <= count+1;
		end
end

endmodule 