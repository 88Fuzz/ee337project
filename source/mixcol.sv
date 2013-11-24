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

	always@(olddata) begin

		if(olddata[127] && olddata[95]) begin //most significant byte
			newdata[127:120] = ((olddata[127:120]<<1)^8'b00011011) ^ (((olddata[95:88]<<1)^8'b00011011)^olddata[95:88]) ^ olddata[63:56] ^ olddata[31:24];
		end else if(olddata[127]) begin
			newdata[127:120] = ((olddata[127:120]<<1)^8'b00011011) ^ (((olddata[95:88]<<1))^olddata[95:88]) ^ olddata[63:56] ^ olddata[31:24];
		end else if(olddata[95]) begin
			newdata[127:120] = ((olddata[127:120]<<1)) ^ (((olddata[95:88]<<1)^8'b00011011)^olddata[95:88]) ^ olddata[63:56] ^ olddata[31:24];
		end else begin
			newdata[127:120] = ((olddata[127:120]<<1)) ^ (((olddata[95:88]<<1))^olddata[95:88]) ^ olddata[63:56] ^ olddata[31:24];
		end

		if(olddata[119] && olddata[87]) begin
			newdata[119:112] = ((olddata[119:112]<<1)^8'b00011011) ^ (((olddata[87:80]<<1)^8'b00011011)^olddata[87:80]) ^ olddata[55:48] ^ olddata[23:16];
		end else if(olddata[119]) begin
			newdata[119:112] = ((olddata[119:112]<<1)^8'b00011011) ^ (((olddata[87:80]<<1))^olddata[87:80]) ^ olddata[55:48] ^ olddata[23:16];
		end else if(olddata[87]) begin
			newdata[119:112] = ((olddata[119:112]<<1)) ^ (((olddata[87:80]<<1)^8'b00011011)^olddata[87:80]) ^ olddata[55:48] ^ olddata[23:16];
		end else begin
			newdata[119:112] = ((olddata[119:112]<<1)) ^ (((olddata[87:80]<<1))^olddata[87:80]) ^ olddata[55:48] ^ olddata[23:16];
		end

		if(olddata[111] && olddata[79]) begin
			newdata[111:104] = ((olddata[111:104]<<1)^8'b00011011) ^ (((olddata[79:72]<<1)^8'b00011011)^olddata[79:72]) ^ olddata[47:40] ^ olddata[15:8];
		end else if(olddata[111]) begin
			newdata[111:104] = ((olddata[111:104]<<1)^8'b00011011) ^ (((olddata[79:72]<<1))^olddata[79:72]) ^ olddata[47:40] ^ olddata[15:8];
		end else if(olddata[79]) begin
			newdata[111:104] = ((olddata[111:104]<<1)) ^ (((olddata[79:72]<<1)^8'b00011011)^olddata[79:72]) ^ olddata[47:40] ^ olddata[15:8];
		end else begin
			newdata[111:104] = ((olddata[111:104]<<1)) ^ (((olddata[79:72]<<1))^olddata[79:72]) ^ olddata[47:40] ^ olddata[15:8];
		end

		if(olddata[103] && olddata[71]) begin
			newdata[103:96] = ((olddata[103:96]<<1)^8'b00011011) ^ (((olddata[71:64]<<1)^8'b00011011)^olddata[71:64]) ^ olddata[39:32] ^ olddata[7:0];
		end else if(olddata[103]) begin
			newdata[103:96] = ((olddata[103:96]<<1)^8'b00011011) ^ (((olddata[71:64]<<1))^olddata[71:64]) ^ olddata[39:32] ^ olddata[7:0];
		end else if(olddata[71]) begin
			newdata[103:96] = ((olddata[103:96]<<1)) ^ (((olddata[71:64]<<1)^8'b00011011)^olddata[71:64]) ^ olddata[39:32] ^ olddata[7:0];
		end else begin
			newdata[103:96] = ((olddata[103:96]<<1)) ^ (((olddata[71:64]<<1))^olddata[71:64]) ^ olddata[39:32] ^ olddata[7:0];
		end

		if(olddata[95] && olddata[63]) begin
			newdata[95:88] = olddata[127:120] ^ ((olddata[95:88]<<1)^8'b00011011) ^ (((olddata[63:56]<<1)^8'b00011011)^olddata[63:56]) ^ olddata[31:24];
		end else if(olddata[95]) begin
			newdata[95:88] = olddata[127:120] ^ ((olddata[95:88]<<1)^8'b00011011) ^ (((olddata[63:56]<<1))^olddata[63:56]) ^ olddata[31:24];
		end else if(olddata[63]) begin
			newdata[95:88] = olddata[127:120] ^ ((olddata[95:88]<<1)) ^ (((olddata[63:56]<<1)^8'b00011011)^olddata[63:56]) ^ olddata[31:24];
		end else begin
			newdata[95:88] = olddata[127:120] ^ ((olddata[95:88]<<1)) ^ (((olddata[63:56]<<1))^olddata[63:56]) ^ olddata[31:24];
		end

		if(olddata[87] && olddata[55]) begin
			newdata[87:80] = olddata[119:112] ^ ((olddata[87:80]<<1)^8'b00011011) ^ (((olddata[55:48]<<1)^8'b00011011)^olddata[55:48]) ^ olddata[23:16];
		end else if(olddata[87]) begin
			newdata[87:80] = olddata[119:112] ^ ((olddata[87:80]<<1)^8'b00011011) ^ (((olddata[55:48]<<1))^olddata[55:48]) ^ olddata[23:16];
		end else if(olddata[55]) begin
			newdata[87:80] = olddata[119:112] ^ ((olddata[87:80]<<1)) ^ (((olddata[55:48]<<1)^8'b00011011)^olddata[55:48]) ^ olddata[23:16];
		end else begin
			newdata[87:80] = olddata[119:112] ^ ((olddata[87:80]<<1)) ^ (((olddata[55:48]<<1))^olddata[55:48]) ^ olddata[23:16];
		end

		if(olddata[79] && olddata[47]) begin
			newdata[79:72] = olddata[111:104] ^ ((olddata[79:72]<<1)^8'b00011011) ^ (((olddata[47:40]<<1)^8'b00011011)^olddata[47:40]) ^ olddata[15:8];
		end else if(olddata[79]) begin
			newdata[79:72] = olddata[111:104] ^ ((olddata[79:72]<<1)^8'b00011011) ^ (((olddata[47:40]<<1))^olddata[47:40]) ^ olddata[15:8];
		end else if(olddata[47]) begin
			newdata[79:72] = olddata[111:104] ^ ((olddata[79:72]<<1)) ^ (((olddata[47:40]<<1)^8'b00011011)^olddata[47:40]) ^ olddata[15:8];
		end else begin
			newdata[79:72] = olddata[111:104] ^ ((olddata[79:72]<<1)) ^ (((olddata[47:40]<<1))^olddata[47:40]) ^ olddata[15:8];
		end

		if(olddata[71] && olddata[39]) begin
			newdata[71:64] = olddata[103:96] ^ ((olddata[71:64]<<1)^8'b00011011) ^ (((olddata[39:32]<<1)^8'b00011011)^olddata[39:32]) ^ olddata[7:0];
		end else if(olddata[71]) begin
			newdata[71:64] = olddata[103:96] ^ ((olddata[71:64]<<1)^8'b00011011) ^ (((olddata[39:32]<<1))^olddata[39:32]) ^ olddata[7:0];
		end else if(olddata[39]) begin
			newdata[71:64] = olddata[103:96] ^ ((olddata[71:64]<<1)) ^ (((olddata[39:32]<<1)^8'b00011011)^olddata[39:32]) ^ olddata[7:0];
		end else begin
			newdata[71:64] = olddata[103:96] ^ ((olddata[71:64]<<1)) ^ (((olddata[39:32]<<1))^olddata[39:32]) ^ olddata[7:0];
		end

		if(olddata[63] && olddata[31]) begin
			newdata[63:56] = olddata[127:120] ^ olddata[95:88] ^ ((olddata[63:56]<<1)^8'b00011011) ^ (((olddata[31:24]<<1)^8'b00011011)^olddata[31:24]);
		end else if(olddata[63]) begin
			newdata[63:56] = olddata[127:120] ^ olddata[95:88] ^ ((olddata[63:56]<<1)^8'b00011011) ^ (((olddata[31:24]<<1))^olddata[31:24]);
		end else if(olddata[31]) begin
			newdata[63:56] = olddata[127:120] ^ olddata[95:88] ^ ((olddata[63:56]<<1)) ^ (((olddata[31:24]<<1)^8'b00011011)^olddata[31:24]);
		end else begin
			newdata[63:56] = olddata[127:120] ^ olddata[95:88] ^ ((olddata[63:56]<<1)) ^ (((olddata[31:24]<<1))^olddata[31:24]);
		end

		if(olddata[55] && olddata[23]) begin
			newdata[55:48] = olddata[119:112] ^ olddata[87:80] ^ ((olddata[55:48]<<1)^8'b00011011) ^ (((olddata[23:16]<<1)^8'b00011011)^olddata[23:16]);
		end else if(olddata[55]) begin
			newdata[55:48] = olddata[119:112] ^ olddata[87:80] ^ ((olddata[55:48]<<1)^8'b00011011) ^ (((olddata[23:16]<<1))^olddata[23:16]);
		end else if(olddata[23]) begin
			newdata[55:48] = olddata[119:112] ^ olddata[87:80] ^ ((olddata[55:48]<<1)) ^ (((olddata[23:16]<<1)^8'b00011011)^olddata[23:16]);
		end else begin
			newdata[55:48] = olddata[119:112] ^ olddata[87:80] ^ ((olddata[55:48]<<1)) ^ (((olddata[23:16]<<1))^olddata[23:16]);
		end

		if(olddata[47] && olddata[15]) begin
			newdata[47:40] = olddata[111:104] ^ olddata[79:72] ^ ((olddata[47:40]<<1)^8'b00011011) ^ (((olddata[15:8]<<1)^8'b00011011)^olddata[15:8]);
		end else if(olddata[47]) begin
			newdata[47:40] = olddata[111:104] ^ olddata[79:72] ^ ((olddata[47:40]<<1)^8'b00011011) ^ (((olddata[15:8]<<1))^olddata[15:8]);
		end else if(olddata[15]) begin
			newdata[47:40] = olddata[111:104] ^ olddata[79:72] ^ ((olddata[47:40]<<1)) ^ (((olddata[15:8]<<1)^8'b00011011)^olddata[15:8]);
		end else begin
			newdata[47:40] = olddata[111:104] ^ olddata[79:72] ^ ((olddata[47:40]<<1)) ^ (((olddata[15:8]<<1))^olddata[15:8]);
		end

		if(olddata[39] && olddata[7]) begin
			newdata[39:32] = olddata[103:96] ^ olddata[71:64] ^ ((olddata[39:32]<<1)^8'b00011011) ^ (((olddata[7:0]<<1)^8'b00011011)^olddata[7:0]);
		end else if(olddata[39]) begin
			newdata[39:32] = olddata[103:96] ^ olddata[71:64] ^ ((olddata[39:32]<<1)^8'b00011011) ^ (((olddata[7:0]<<1))^olddata[7:0]);
		end else if(olddata[7]) begin
			newdata[39:32] = olddata[103:96] ^ olddata[71:64] ^ ((olddata[39:32]<<1)) ^ (((olddata[7:0]<<1)^8'b00011011)^olddata[7:0]);
		end else begin
			newdata[39:32] = olddata[103:96] ^ olddata[71:64] ^ ((olddata[39:32]<<1)) ^ (((olddata[7:0]<<1))^olddata[7:0]);
		end

		if(olddata[31] && olddata[127]) begin
			newdata[31:24] = (((olddata[127:120]<<1)^8'b00011011)^olddata[127:120]) ^ olddata[95:88] ^ olddata[63:56] ^ ((olddata[31:24]<<1)^8'b00011011);
		end else if(olddata[31]) begin
			newdata[31:24] = (((olddata[127:120]<<1))^olddata[127:120]) ^ olddata[95:88] ^ olddata[63:56] ^ ((olddata[31:24]<<1)^8'b00011011);
		end else if(olddata[127]) begin
			newdata[31:24] = (((olddata[127:120]<<1)^8'b00011011)^olddata[127:120]) ^ olddata[95:88] ^ olddata[63:56] ^ ((olddata[31:24]<<1));
		end else begin
			newdata[31:24] = (((olddata[127:120]<<1))^olddata[127:120]) ^ olddata[95:88] ^ olddata[63:56] ^ ((olddata[31:24]<<1));
		end

		if(olddata[23] && olddata[119]) begin
			newdata[23:16] = (((olddata[119:112]<<1)^8'b00011011)^olddata[119:112]) ^ olddata[87:80] ^ olddata[55:48] ^ ((olddata[23:16]<<1)^8'b00011011);
		end else if(olddata[23]) begin
			newdata[23:16] = (((olddata[119:112]<<1))^olddata[119:112]) ^ olddata[87:80] ^ olddata[55:48] ^ ((olddata[23:16]<<1)^8'b00011011);
		end else if(olddata[119]) begin
			newdata[23:16] = (((olddata[119:112]<<1)^8'b00011011)^olddata[119:112]) ^ olddata[87:80] ^ olddata[55:48] ^ ((olddata[23:16]<<1));
		end else begin
			newdata[23:16] = (((olddata[119:112]<<1))^olddata[119:112]) ^ olddata[87:80] ^ olddata[55:48] ^ ((olddata[23:16]<<1));
		end

		if(olddata[15] && olddata[111]) begin
			newdata[15:8] = (((olddata[111:104]<<1)^8'b00011011)^olddata[111:104]) ^ olddata[79:72] ^ olddata[47:40] ^ ((olddata[15:8]<<1)^8'b00011011);
		end else if(olddata[15]) begin
			newdata[15:8] = (((olddata[111:104]<<1))^olddata[111:104]) ^ olddata[79:72] ^ olddata[47:40] ^ ((olddata[15:8]<<1)^8'b00011011);
		end else if(olddata[111]) begin
			newdata[15:8] = (((olddata[111:104]<<1)^8'b00011011)^olddata[111:104]) ^ olddata[79:72] ^ olddata[47:40] ^ ((olddata[15:8]<<1));
		end else begin
			newdata[15:8] = (((olddata[111:104]<<1))^olddata[111:104]) ^ olddata[79:72] ^ olddata[47:40] ^ ((olddata[15:8]<<1));
		end

		if(olddata[7] && olddata[103]) begin //least significant byte
			newdata[7:0] = (((olddata[103:96]<<1)^8'b00011011)^olddata[103:96]) ^ olddata[71:64] ^ olddata[39:32] ^ ((olddata[7:0]<<1)^8'b00011011);
		end else if(olddata[7]) begin
			newdata[7:0] = (((olddata[103:96]<<1))^olddata[103:96]) ^ olddata[71:64] ^ olddata[39:32] ^ ((olddata[7:0]<<1)^8'b00011011);
		end else if(olddata[103]) begin
			newdata[7:0] = (((olddata[103:96]<<1)^8'b00011011)^olddata[103:96]) ^ olddata[71:64] ^ olddata[39:32] ^ ((olddata[7:0]<<1));
		end else begin
			newdata[7:0] = (((olddata[103:96]<<1))^olddata[103:96]) ^ olddata[71:64] ^ olddata[39:32] ^ ((olddata[7:0]<<1));
		end

		mixcol_finished = 1'b1;
	end

endmodule
