// $Id: $
// File name:   tb_controller.sv
// Created:     11/24/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Test Bench for the Controller module

`timescale 1ns/100ps

module tb_controller ();

	reg tb_clk;
	reg tb_n_rst;
	reg tb_addrMatch;
	reg tb_HSELx;
	reg tb_mWrite;
	reg tb_dataReady;
	reg tb_mRead;
	reg tb_invalid;
	//reg tb_finished;
	reg tb_keyexp_finished;
	reg tb_sbytes_finished;
	reg tb_srows_finished;
	reg tb_mcol_finished;
	reg tb_around_finished;
	reg tb_HREADYOUT;
	reg tb_readk_enable;
	reg tb_read_enable;
	reg tb_write_enable;
	reg tb_keyexp_enable;
	reg tb_sbytes_enable;
	reg tb_srows_enable;
	reg tb_mcol_enable;
	reg tb_around_enable;
	reg tb_hresp_error;
	reg [3:0] tb_roundnum;

	controller controller
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.addrMatch(tb_addrMatch),
		.HSELx(tb_HSELx),
		.mWrite(tb_mWrite),
		.dataReady(tb_dataReady),
		.mRead(tb_mRead),
		//.finished(tb_finished),
		.keyexp_finished(tb_keyexp_finished),
		.sbytes_finished(tb_sbytes_finished),
		.srows_finished(tb_srows_finished),
		.mcol_finished(tb_mcol_finished),
		.around_finished(tb_around_finished),
		.invalid(tb_invalid),
		.HREADYOUT(tb_HREADYOUT),
		.readk_enable(tb_readk_enable),
		.read_enable(tb_read_enable),
		.write_enable(tb_write_enable),
		.keyexp_enable(tb_keyexp_enable),
		.sbytes_enable(tb_sbytes_enable),
		.srows_enable(tb_srows_enable),
		.mcol_enable(tb_mcol_enable),
		.around_enable(tb_around_enable),
		.hresp_error(tb_hresp_error),
		.roundnum(tb_roundnum)
	);

	initial begin
		tb_clk = 1'b0;
		tb_n_rst = 1'b1;
		tb_addrMatch = 1'b1;
		tb_HSELx = 1'b0;
		tb_mWrite = 1'b0;
		tb_dataReady = 1'b0;
		tb_mRead = 1'b0;
		tb_keyexp_finished = 1'b0;
		tb_sbytes_finished = 1'b0;
		tb_srows_finished = 1'b0;
		tb_mcol_finished = 1'b0;
		tb_around_finished = 1'b0;

		#20ns
		tb_n_rst = 1'b0;
		#10ns
		tb_n_rst = 1'b1;
		tb_invalid = 1'b0;

		#33ns//63
		tb_HSELx = 1'b1;

		#20ns
		tb_mWrite = 1'b1;

		#20ns
		//What makes data ready?
		tb_dataReady = 1'b1;
		
		#100ns
		//tb_finished = 1'b0;

		#20ns
		tb_keyexp_finished = 1'b1;
		#10ns
		tb_keyexp_finished = 1'b0;

		#20ns
		tb_around_finished = 1'b1;
		#10ns
		tb_around_finished = 1'b0;

		#60ns
		tb_keyexp_finished = 1'b1;
		#10ns
		tb_keyexp_finished = 1'b0;

		#80ns
		tb_sbytes_finished = 1'b1;
		#10ns
		tb_sbytes_finished = 1'b0;

		#40ns
		tb_srows_finished = 1'b1;
		#10ns
		tb_srows_finished = 1'b0;

		#70ns//210
		tb_mcol_finished = 1'b1;
		#10ns
		tb_mcol_finished = 1'b0;

		#50ns
		tb_around_finished = 1'b1;
		#10ns
		tb_around_finished = 1'b0;

		#40ns
		tb_mcol_finished = 1'b1;
		tb_srows_finished = 1'b1;
		tb_sbytes_finished = 1'b1;
		tb_keyexp_finished = 1'b1;
		tb_around_finished = 1'b1;

		//#410ns
		//tb_mRead = 1'b1;
		//tb_mWrite = 1'b1;
		//tb_finished = 1'b1;
	end

	always begin
		#5ns
		tb_clk = !tb_clk;
	end

endmodule
