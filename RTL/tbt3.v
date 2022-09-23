// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// *****************************************************************************
// This file contains a Verilog test bench with test vectors .The test vectors  
// are exported from a vector file in the Quartus Waveform Editor and apply to  
// the top level entity of the current Quartus project .The user can use this   
// testbench to simulate his design using a third-party simulation tool .       
// *****************************************************************************
// Generated on "03/20/2022 12:29:40"
                                                                                
// Verilog Test Bench (with test vectors) for design :                          bresen
// 
// Simulation tool : 3rd Party
// 

`timescale 1 ps/ 1 ps
module tbt3();
// constants                                           
// general purpose registers
reg CLK50;
reg plot;
reg [7:0] r;
reg [7:0] xc;
reg [6:0] yc;
// wires                                               
wire holdclk;
wire [7:0] xo;
wire [6:0] yo;

// assign statements (if any)                          
bresen i1 (
// port map - connection between master ports and signals/registers   
	.CLK50(CLK50),
	.plot(plot),
	.r(r),
	.xc(xc),
	.xo(xo),
	.yc(yc),
	.yo(yo)
);
initial 
begin 
#3000000 $finish;
end 

// CLK50
always
begin
	CLK50 = 1'b0;
	CLK50 = #5000 1'b1;
	#5000;
end 
// xc[ 7 ]
initial
begin
	xc[7] = 1'b0;
end 
// xc[ 6 ]
initial
begin
	xc[6] = 1'b1;
end 
// xc[ 5 ]
initial
begin
	xc[5] = 1'b0;
end 
// xc[ 4 ]
initial
begin
	xc[4] = 1'b1;
end 
// xc[ 3 ]
initial
begin
	xc[3] = 1'b0;
end 
// xc[ 2 ]
initial
begin
	xc[2] = 1'b0;
end 
// xc[ 1 ]
initial
begin
	xc[1] = 1'b0;
end 
// xc[ 0 ]
initial
begin
	xc[0] = 1'b0;
end 
// yc[ 6 ]
initial
begin
	yc[6] = 1'b0;
end 
// yc[ 5 ]
initial
begin
	yc[5] = 1'b1;
end 
// yc[ 4 ]
initial
begin
	yc[4] = 1'b1;
end 
// yc[ 3 ]
initial
begin
	yc[3] = 1'b1;
end 
// yc[ 2 ]
initial
begin
	yc[2] = 1'b1;
end 
// yc[ 1 ]
initial
begin
	yc[1] = 1'b0;
end 
// yc[ 0 ]
initial
begin
	yc[0] = 1'b0;
end 
// r[ 7 ]
initial
begin
	r[7] = 1'b0;
end 
// r[ 6 ]
initial
begin
	r[6] = 1'b0;
end 
// r[ 5 ]
initial
begin
	r[5] = 1'b0;
end 
// r[ 4 ]
initial
begin
	r[4] = 1'b1;
end 
// r[ 3 ]
initial
begin
	r[3] = 1'b0;
end 
// r[ 2 ]
initial
begin
	r[2] = 1'b1;
end 
// r[ 1 ]
initial
begin
	r[1] = 1'b0;
end 
// r[ 0 ]
initial
begin
	r[0] = 1'b0;
end 

// plot
initial
begin
	plot = 1'b1;
	//plot = #10000 1'b0;
end 
endmodule

