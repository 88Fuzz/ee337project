// $Id: $
// File name:   tb_mixcol.sv
// Created:     11/19/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Mix Columns Step

module tb_mixcol();

	reg tb_mixcol_enable;
	reg [127:0] tb_olddata;
	reg [127:0] tb_newdata;
	reg tb_mixcol_finished;

	mixcol DUT
	(
		.mixcol_enable(tb_mixcol_enable),
		.olddata(tb_olddata),
		.newdata(tb_newdata),
		.mixcol_finished(tb_mixcol_finished)
	);

	initial begin
		tb_mixcol_enable = 1'b1;
		//tb_olddata = 128'hd4e0b81ebfb441275d52119830aef1e5;
		tb_olddata = 128'hc601f2dbc6010a13c6012253c6015c45;

		#30ns
		tb_mixcol_enable = 1'b0;

	end
endmodule
