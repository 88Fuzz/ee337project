// $Id: $
// File name:   mixcol.sv
// Created:     11/18/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Mix Columns

module mixcol
(
	input wire mixcol_enable,
	input wire [127:0] olddata,
	output reg [127:0] newdata,
	output reg mixcol_finished
);
	//assign newdata[103:96] = (2*olddata[103:96]) ^ (3*olddata[;

	assign newdata[7:0] = (2'd2*olddata[7:0]) ^ olddata[39:32] ^ olddata[71:64] ^ (2'd3*olddata[103:96]);
	assign newdata[39:32] = (2'd3*olddata[7:0]) ^ (2'd2*olddata[39:32]) ^ olddata[71:64] ^ olddata[103:96];
	assign newdata[71:64] = olddata[7:0] ^ (2'd3*olddata[39:32]) ^ (2'd2*olddata[71:64]) ^ olddata[103:96];
	assign newdata[103:96] = olddata[7:0] ^ olddata[39:32] ^ (2'd3*olddata[71:64]) ^ (2'd2*olddata[103:96]);

	assign newdata[15:8] = (2'd2*olddata[15:8]) ^ olddata[47:40] ^ olddata[79:72] ^ (2'd3*olddata[111:104]);
	assign newdata[47:40] = (2'd3*olddata[15:8]) ^ (2'd2*olddata[47:40]) ^ olddata[79:72] ^ olddata[111:104];
	assign newdata[79:72] = olddata[15:8] ^ (2'd3*olddata[47:40]) ^ (2'd2*olddata[79:72]) ^ olddata[111:104];
	assign newdata[111:104] = olddata[15:8] ^ olddata[47:40] ^ (2'd3*olddata[79:72]) ^ (2'd2*olddata[111:104]);

	assign newdata[23:16] = (2'd2*olddata[23:16]) ^ olddata[55:48] ^ olddata[87:80] ^ (3*olddata[119:112]);
	assign newdata[55:48] = (2'd3*olddata[23:16]) ^ (2'd2*olddata[55:48]) ^ olddata[87:80] ^ olddata[119:112];
	assign newdata[87:80] = olddata[23:16] ^ (2'd3*olddata[55:48]) ^ (2'd2*olddata[87:80]) ^ olddata[119:112];
	assign newdata[119:112] = olddata[23:16] ^ olddata[55:48] ^ (2'd3*olddata[87:80]) ^ (2'd2*olddata[119:112]);

	assign newdata[31:24] = (2'd2*olddata[31:24]) ^ olddata[63:56] ^ olddata[95:88] ^ (2'd3*olddata[127:120]);
	assign newdata[63:56] = (2'd3*olddata[31:24]) ^ (2'd2*olddata[63:56]) ^ olddata[95:88] ^ olddata[127:120];
	assign newdata[95:88] = olddata[31:24] ^ (2'd3*olddata[63:56]) ^ (2'd2*olddata[95:88]) ^ olddata[127:120];
	assign newdata[127:120] = olddata[31:24] ^ olddata[63:56] ^ (2'd3*olddata[95:88]) ^ (2'd2*olddata[127:120]);

endmodule
