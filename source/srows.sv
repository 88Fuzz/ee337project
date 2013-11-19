// $Id: $
// File name:   srows.sv
// Created:     11/18/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Shift Rows

module srows
(
	//input wire clk,
	//input wire n_rst,
	input wire [127:0] olddata,
	input wire srows_enable,
	output reg srows_finished,
	output reg [127:0] newdata
);

	assign newdata = srows_enable ? {olddata[31:0],olddata[63:40],olddata[39:32],olddata[95:80],olddata[79:64],olddata[127:119],olddata[119:96]} : olddata;

	assign srows_finished = (newdata == olddata) ? 1'b0 : 1'b1;
/*
	always@(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			newdata <= olddata;
		end else begin
			if(srows_enable) begin
				newdata <= {olddata[31:0],olddata[63:40],olddata[39:32],olddata[95:80],olddata[79:64],olddata[127:119],olddata[119:96]};
				srows_finished = 1'b1;
			end
		end
	end		
*/

endmodule
