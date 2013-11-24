// $Id: $
// File name:   tb_controller.sv
// Created:     11/24/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Test Bench for the Controller module

module tb_controller ();

	reg tb_clk;
	reg tb_n_rst;
	reg tb_addrMatch;
	reg tb_HSELx;
	reg tb_mWrite;
	reg tb_dataReady;
	reg tb_mRead;
	reg tb_finished;
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

	controller test
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.addrMatch(tb_addrMatch),
		.HSELx(tb_HSELx),
		.mWrite(tb_mWrite),
		.dataReady(tb_dataReady),
		.mRead(tb_mRead),
		.finished(tb_finished),
		.keyexp_finished(tb_keyexp_finished),
		.sbytes_finished(tb_sbytes_finished),
		.srows_finished(tb_srows_finished),
		.mcol_finished(tb_mcol_finished),
		.around_finished(tb_around_finished),
		.HREADYOUT(tb_HREADYOUT),
		.readk_enable(tb_readk_enable),
		.read_enable(tb_read_enable),
		.write_enable(tb_write_enable),
		.keyexp_enable(tb_keyexp_enable),
		.sbytes_enable(tb_sbytes_enable),
		.srows_enable(tb_srows_enable),
		.mcol_enable(tb_mcol_enable),
		.around_enable(tb_around_enable)
	);

	initial begin
		tb_clk = 1'b0;
	end

	always begin
		#5ns
		tb_clk = !tb_clk;
	end

endmodule
