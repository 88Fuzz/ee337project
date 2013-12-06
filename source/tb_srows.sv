// $Id: $
// File name:   tb_srows.sv
// Created:     11/19/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Shift Rows Module

module tb_srows();

	reg tb_clk;
	reg tb_n_rst;
	reg [127:0] tb_sramReadV;
	reg tb_srows_enable;
	reg tb_srows_finished;
	reg [127:0] tb_sramWriteV;
	reg tb_sramRead;
	reg tb_sramWrite;
	reg tb_sramDump;
	reg tb_sramInit;
	reg [15:0] tb_sramAddr;
	reg [2:0] tb_sramDumpNum;
	reg [2:0] tb_sramInitNum;

	reg otherdump;
	reg otherinit;
	reg [2:0] otherdumpnum;
	reg [2:0] otherinitnum;

	srows DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.sramReadValue(tb_sramReadV),
		.srows_enable(tb_srows_enable),
		.srows_finished(tb_srows_finished),
		.sramWriteValue(tb_sramWriteV),
		.sramRead(tb_sramRead),
		.sramWrite(tb_sramWrite),
		.sramDump(tb_sramDump),
		.sramInit(tb_sramInit),
		.sramAddr(tb_sramAddr),
		.sramDumpNum(tb_sramDumpNum),
		.sramInitNum(tb_sramInitNum)
	);

	testing_sram test
	(
		.read(tb_sramRead),
		.write(tb_sramWrite),
		.addr(tb_sramAddr),
		.dump(otherdump),
		.dumpNum(otherdumpnum),
		.initNum(otherinitnum),
		.init(otherinit),
		.write_data(tb_sramWriteV),
		.read_data(tb_sramReadV)
	);

	always begin
		#5ns
		tb_clk = !tb_clk;
	end

	initial begin
		tb_srows_enable = 1'b1;
		tb_clk = 1'b0;
		tb_n_rst = 1'b1;
		otherinitnum = 1;
		otherdumpnum = 2;
		otherdump = 0;
		//tb_sramReadV = '0;

		#20ns
		otherinit = 1;
		tb_n_rst = 1'b0;
		#10ns
		otherinit = 0;
		tb_n_rst = 1'b1;

		#80ns
		tb_srows_enable = 1'b0;
		otherdump = 1;
	end

	/*always@(tb_sramAddr) begin
		if(tb_sramAddr == 32) begin
			tb_sramReadV = 128'h112233445566778899AABBCCDDEEFF00;
		end
	end*/

endmodule
