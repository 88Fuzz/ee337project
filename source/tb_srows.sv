// $Id: $
// File name:   tb_srows.sv
// Created:     11/19/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Shift Rows Module

module tb_srows();

	reg [127:0] tb_olddata;
	reg tb_srows_enable;
	reg tb_srows_finished;
	reg [127:0] tb_newdata;

	srows DUT
	(
		.olddata(tb_olddata),
		.srows_enable(tb_srows_enable),
		.srows_finished(tb_srows_finished),
		.newdata(tb_newdata)
	);

	initial begin
		tb_srows_enable = 1'b1;
		tb_olddata = 128'h112233445566778899AABBCCDDEEFF00;

		#30ns
		tb_srows_enable = 1'b0;
		tb_olddata = 128'h6677889900AABBCCDDEEFF1122334455;

		#30ns
		tb_srows_enable = 1'b1;

		#30ns
		tb_srows_enable = 1'b0;
	end
endmodule
