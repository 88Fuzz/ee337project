// $Id: $
// File name:   sbyteswrap.sv
// Created:     11/30/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Wrapper for sbytes

module sybteswrap
(
	input wire clk,
	input wire n_rst,
	input wire sbytes_enable,
	input wire [127:0] olddata,
	output reg [127:0] newdata,
	output reg sbytes_finished
);

endmodule
