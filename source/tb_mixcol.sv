// $Id: $
// File name:   tb_mixcol.sv
// Created:     11/19/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Mix Columns Step

module tb_mixcol();

	reg tb_clk;
	reg tb_n_rst;
	reg tb_mixcol_enable;
	reg [127:0] tb_sramReadV;
	reg [127:0] tb_sramWriteV;
	reg tb_mixcol_finished;
	reg tb_sramRead;
	reg tb_sramWrite;
	reg tb_sramDump;
	reg tb_sramInit;
	reg [15:0] tb_sramAddr;
	reg [2:0] tb_sramDumpNum;
	reg [2:0] tb_sramInitNum;

	mixcol DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.mixcol_enable(tb_mixcol_enable),
		.sramReadValue(tb_sramReadV),
		.sramWriteValue(tb_sramWriteV),
		.mixcol_finished(tb_mixcol_finished),
		.sramRead(tb_sramRead),
		.sramWrite(tb_sramWrite),
		.sramDump(tb_sramDump),
		.sramInit(tb_sramInit),
		.sramAddr(tb_sramAddr),
		.sramDumpNum(tb_sramDumpNum),
		.sramInitNum(tb_sramInitNum)
	);

	always begin
		#5ns
		tb_clk = !tb_clk;
	end

	initial begin
		tb_mixcol_enable = 1'b1;
		tb_clk = 1'b0;
		tb_n_rst = 1'b1;
		tb_sramReadV = '0;

		#20ns
		tb_n_rst = 1'b0;
		#10ns
		tb_n_rst = 1'b1;
		//tb_olddata = 128'hd4e0b81ebfb441275d52119830aef1e5;
		#120ns
		tb_mixcol_enable = 1'b0;
	end

	always@(tb_sramAddr) begin
		if(tb_sramAddr == 32) begin
			tb_sramReadV = 128'hd4bf5d30e0b452aeb84111f11e2798e5;//						   hc601f2dbc6010a13c6012253c6015c45;
		end
	end

	always@(tb_mixcol_finished) begin
		#15ns
		if(tb_mixcol_finished) begin
			tb_mixcol_enable = 1'b0;
		end
	end	
endmodule
