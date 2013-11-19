// $Id: $
// File name:   tb_addround.sv
// Created:     11/19/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Add Round Key Module

module tb_addround();

	reg tb_n_rst;
	reg tb_around_enable;
	reg [7:0] tb_subkey;
	reg [7:0] tb_olddata;
	reg [7:0] tb_newdata;

	addround DUT
	(
		.n_rst(tb_n_rst),
		.around_enable(tb_around_enable),
		.subkey(tb_subkey),
		.olddata(tb_olddata),
		.newdata(tb_newdata)
	);

	initial begin
		tb_n_rst = 1'b1;
		tb_around_enable = 1'b1;
		tb_subkey = 8'b11001100;
		tb_olddata = 8'b10101010;

		#20ns
		tb_n_rst = 1'b0;
		tb_around_enable = 1'b1;
		tb_subkey = 8'b11001100;
		tb_olddata = 8'b10101010;

		#20ns
		tb_n_rst = 1'b1;
		tb_around_enable = 1'b1;
		tb_subkey = 8'b11001100;
		tb_olddata = 8'b10101010;

		#20ns
		tb_n_rst = 1'b1;
		tb_around_enable = 1'b0;
		tb_subkey = 8'b11001100;
		tb_olddata = 8'b10101010;

		#20ns
		tb_n_rst = 1'b1;
		tb_around_enable = 1'b0;
		tb_subkey = 8'b00001111;
		tb_olddata = 8'b11000011;

		#20ns
		tb_n_rst = 1'b1;
		tb_around_enable = 1'b1;
		tb_subkey = 8'b00001111;
		tb_olddata = 8'b11000011;
	end
endmodule
