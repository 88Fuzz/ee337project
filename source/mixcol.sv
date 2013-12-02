// $Id: $
// File name:   mixcol.sv
// Created:     11/18/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Mix Columns

module mixcol
(
	input wire clk,
	input wire n_rst,
	input wire mixcol_enable,
	input wire [127:0] sramReadValue,
	output reg [127:0] sramWriteValue,
	output reg mixcol_finished,
	output reg sramRead,
	output reg sramWrite,
	output reg sramDump,
	output reg sramInit,
	output reg [15:0] sramAddr,
	output reg [2:0] sramDumpNum,
	output reg [2:0] sramInitNum
);

	reg [127:0] olddata;
	reg [127:0] newdata;
	reg [127:0] nextdata;
	reg [127:0] currdata;
	reg activate;
	reg currfinish;
	reg nextfinish;

	typedef enum bit [3:0] {idle, setaddr, readsram1, readagain, mixer, writeaddr, writesram, finito, buff1, buff2} stateType;
	stateType state, nextstate;

	always@(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			state <= idle;
			currfinish <= 1'b0;
			currdata <= '0;
		end else begin
			state <= nextstate;
			currfinish <= nextfinish;
			currdata <= nextdata;
		end
	end

	assign olddata = sramReadValue;
	assign sramWriteValue = newdata;
	assign mixcol_finished = currfinish;

	always@(state, mixcol_enable) begin
		nextstate = state;
		case(state)
			idle: begin
				if(mixcol_enable) begin
					nextstate = setaddr;
				end else begin
					nextstate = idle;
				end
			end
			setaddr: begin
				nextstate = readsram1;
			end
			readsram1: begin
				nextstate = readagain;
			end
			readagain: begin
				nextstate = mixer;
			end
			mixer: begin
				nextstate = writeaddr;
			end
			writeaddr: begin
				nextstate = writesram;
			end
			writesram: begin
				nextstate = finito;
			end
			finito: begin
				nextstate = buff1;
			end
			buff1: begin
				nextstate = buff2;
			end
			buff2: begin
				nextstate = idle;
			end
			default: begin
				nextstate = state;
			end
		endcase
	end

	always@(state) begin
		//sramWriteValue = 1'b0;
		sramRead = 1'b0;
		sramWrite = 1'b0;
		sramDump = 1'b0;
		sramInit = 1'b0;
		sramAddr = '0;
		sramDumpNum = '0;
		sramInitNum = '0;
		nextfinish = 1'b0;
		activate = 1'b0;
		case(state)
			idle: begin
			end
			setaddr: begin
				sramAddr = 32;
			end
			readsram1: begin
				sramAddr = 32;
				sramRead = 1'b1;
			end
			readagain: begin
			end
			mixer: begin
				activate = 1'b1;
			end
			writeaddr: begin
				sramAddr = 32;
			end
			writesram: begin
				sramAddr = 32;
				sramWrite = 1'b1;
			end
			finito: begin
				nextfinish = 1'b1;
			end
			buff1: begin
			end
			buff2: begin
			end
			default: begin
			end
		endcase
	end

	assign newdata = currdata;

	always@(olddata, activate, currdata) begin
		nextdata = currdata;
		if(activate) begin
		if(olddata[127] && olddata[95]) begin //most significant byte
			nextdata[127:120] = ((olddata[127:120]<<1)^8'b00011011) ^ (((olddata[95:88]<<1)^8'b00011011)^olddata[95:88]) ^ olddata[63:56] ^ olddata[31:24];
		end else if(olddata[127]) begin
			nextdata[127:120] = ((olddata[127:120]<<1)^8'b00011011) ^ (((olddata[95:88]<<1))^olddata[95:88]) ^ olddata[63:56] ^ olddata[31:24];
		end else if(olddata[95]) begin
			nextdata[127:120] = ((olddata[127:120]<<1)) ^ (((olddata[95:88]<<1)^8'b00011011)^olddata[95:88]) ^ olddata[63:56] ^ olddata[31:24];
		end else begin
			nextdata[127:120] = ((olddata[127:120]<<1)) ^ (((olddata[95:88]<<1))^olddata[95:88]) ^ olddata[63:56] ^ olddata[31:24];
		end

		if(olddata[119] && olddata[87]) begin
			nextdata[119:112] = ((olddata[119:112]<<1)^8'b00011011) ^ (((olddata[87:80]<<1)^8'b00011011)^olddata[87:80]) ^ olddata[55:48] ^ olddata[23:16];
		end else if(olddata[119]) begin
			nextdata[119:112] = ((olddata[119:112]<<1)^8'b00011011) ^ (((olddata[87:80]<<1))^olddata[87:80]) ^ olddata[55:48] ^ olddata[23:16];
		end else if(olddata[87]) begin
			nextdata[119:112] = ((olddata[119:112]<<1)) ^ (((olddata[87:80]<<1)^8'b00011011)^olddata[87:80]) ^ olddata[55:48] ^ olddata[23:16];
		end else begin
			nextdata[119:112] = ((olddata[119:112]<<1)) ^ (((olddata[87:80]<<1))^olddata[87:80]) ^ olddata[55:48] ^ olddata[23:16];
		end

		if(olddata[111] && olddata[79]) begin
			nextdata[111:104] = ((olddata[111:104]<<1)^8'b00011011) ^ (((olddata[79:72]<<1)^8'b00011011)^olddata[79:72]) ^ olddata[47:40] ^ olddata[15:8];
		end else if(olddata[111]) begin
			nextdata[111:104] = ((olddata[111:104]<<1)^8'b00011011) ^ (((olddata[79:72]<<1))^olddata[79:72]) ^ olddata[47:40] ^ olddata[15:8];
		end else if(olddata[79]) begin
			nextdata[111:104] = ((olddata[111:104]<<1)) ^ (((olddata[79:72]<<1)^8'b00011011)^olddata[79:72]) ^ olddata[47:40] ^ olddata[15:8];
		end else begin
			nextdata[111:104] = ((olddata[111:104]<<1)) ^ (((olddata[79:72]<<1))^olddata[79:72]) ^ olddata[47:40] ^ olddata[15:8];
		end

		if(olddata[103] && olddata[71]) begin
			nextdata[103:96] = ((olddata[103:96]<<1)^8'b00011011) ^ (((olddata[71:64]<<1)^8'b00011011)^olddata[71:64]) ^ olddata[39:32] ^ olddata[7:0];
		end else if(olddata[103]) begin
			nextdata[103:96] = ((olddata[103:96]<<1)^8'b00011011) ^ (((olddata[71:64]<<1))^olddata[71:64]) ^ olddata[39:32] ^ olddata[7:0];
		end else if(olddata[71]) begin
			nextdata[103:96] = ((olddata[103:96]<<1)) ^ (((olddata[71:64]<<1)^8'b00011011)^olddata[71:64]) ^ olddata[39:32] ^ olddata[7:0];
		end else begin
			nextdata[103:96] = ((olddata[103:96]<<1)) ^ (((olddata[71:64]<<1))^olddata[71:64]) ^ olddata[39:32] ^ olddata[7:0];
		end

		if(olddata[95] && olddata[63]) begin
			nextdata[95:88] = olddata[127:120] ^ ((olddata[95:88]<<1)^8'b00011011) ^ (((olddata[63:56]<<1)^8'b00011011)^olddata[63:56]) ^ olddata[31:24];
		end else if(olddata[95]) begin
			nextdata[95:88] = olddata[127:120] ^ ((olddata[95:88]<<1)^8'b00011011) ^ (((olddata[63:56]<<1))^olddata[63:56]) ^ olddata[31:24];
		end else if(olddata[63]) begin
			nextdata[95:88] = olddata[127:120] ^ ((olddata[95:88]<<1)) ^ (((olddata[63:56]<<1)^8'b00011011)^olddata[63:56]) ^ olddata[31:24];
		end else begin
			nextdata[95:88] = olddata[127:120] ^ ((olddata[95:88]<<1)) ^ (((olddata[63:56]<<1))^olddata[63:56]) ^ olddata[31:24];
		end

		if(olddata[87] && olddata[55]) begin
			nextdata[87:80] = olddata[119:112] ^ ((olddata[87:80]<<1)^8'b00011011) ^ (((olddata[55:48]<<1)^8'b00011011)^olddata[55:48]) ^ olddata[23:16];
		end else if(olddata[87]) begin
			nextdata[87:80] = olddata[119:112] ^ ((olddata[87:80]<<1)^8'b00011011) ^ (((olddata[55:48]<<1))^olddata[55:48]) ^ olddata[23:16];
		end else if(olddata[55]) begin
			nextdata[87:80] = olddata[119:112] ^ ((olddata[87:80]<<1)) ^ (((olddata[55:48]<<1)^8'b00011011)^olddata[55:48]) ^ olddata[23:16];
		end else begin
			nextdata[87:80] = olddata[119:112] ^ ((olddata[87:80]<<1)) ^ (((olddata[55:48]<<1))^olddata[55:48]) ^ olddata[23:16];
		end

		if(olddata[79] && olddata[47]) begin
			nextdata[79:72] = olddata[111:104] ^ ((olddata[79:72]<<1)^8'b00011011) ^ (((olddata[47:40]<<1)^8'b00011011)^olddata[47:40]) ^ olddata[15:8];
		end else if(olddata[79]) begin
			nextdata[79:72] = olddata[111:104] ^ ((olddata[79:72]<<1)^8'b00011011) ^ (((olddata[47:40]<<1))^olddata[47:40]) ^ olddata[15:8];
		end else if(olddata[47]) begin
			nextdata[79:72] = olddata[111:104] ^ ((olddata[79:72]<<1)) ^ (((olddata[47:40]<<1)^8'b00011011)^olddata[47:40]) ^ olddata[15:8];
		end else begin
			nextdata[79:72] = olddata[111:104] ^ ((olddata[79:72]<<1)) ^ (((olddata[47:40]<<1))^olddata[47:40]) ^ olddata[15:8];
		end

		if(olddata[71] && olddata[39]) begin
			nextdata[71:64] = olddata[103:96] ^ ((olddata[71:64]<<1)^8'b00011011) ^ (((olddata[39:32]<<1)^8'b00011011)^olddata[39:32]) ^ olddata[7:0];
		end else if(olddata[71]) begin
			nextdata[71:64] = olddata[103:96] ^ ((olddata[71:64]<<1)^8'b00011011) ^ (((olddata[39:32]<<1))^olddata[39:32]) ^ olddata[7:0];
		end else if(olddata[39]) begin
			nextdata[71:64] = olddata[103:96] ^ ((olddata[71:64]<<1)) ^ (((olddata[39:32]<<1)^8'b00011011)^olddata[39:32]) ^ olddata[7:0];
		end else begin
			nextdata[71:64] = olddata[103:96] ^ ((olddata[71:64]<<1)) ^ (((olddata[39:32]<<1))^olddata[39:32]) ^ olddata[7:0];
		end

		if(olddata[63] && olddata[31]) begin
			nextdata[63:56] = olddata[127:120] ^ olddata[95:88] ^ ((olddata[63:56]<<1)^8'b00011011) ^ (((olddata[31:24]<<1)^8'b00011011)^olddata[31:24]);
		end else if(olddata[63]) begin
			nextdata[63:56] = olddata[127:120] ^ olddata[95:88] ^ ((olddata[63:56]<<1)^8'b00011011) ^ (((olddata[31:24]<<1))^olddata[31:24]);
		end else if(olddata[31]) begin
			nextdata[63:56] = olddata[127:120] ^ olddata[95:88] ^ ((olddata[63:56]<<1)) ^ (((olddata[31:24]<<1)^8'b00011011)^olddata[31:24]);
		end else begin
			nextdata[63:56] = olddata[127:120] ^ olddata[95:88] ^ ((olddata[63:56]<<1)) ^ (((olddata[31:24]<<1))^olddata[31:24]);
		end

		if(olddata[55] && olddata[23]) begin
			nextdata[55:48] = olddata[119:112] ^ olddata[87:80] ^ ((olddata[55:48]<<1)^8'b00011011) ^ (((olddata[23:16]<<1)^8'b00011011)^olddata[23:16]);
		end else if(olddata[55]) begin
			nextdata[55:48] = olddata[119:112] ^ olddata[87:80] ^ ((olddata[55:48]<<1)^8'b00011011) ^ (((olddata[23:16]<<1))^olddata[23:16]);
		end else if(olddata[23]) begin
			nextdata[55:48] = olddata[119:112] ^ olddata[87:80] ^ ((olddata[55:48]<<1)) ^ (((olddata[23:16]<<1)^8'b00011011)^olddata[23:16]);
		end else begin
			nextdata[55:48] = olddata[119:112] ^ olddata[87:80] ^ ((olddata[55:48]<<1)) ^ (((olddata[23:16]<<1))^olddata[23:16]);
		end

		if(olddata[47] && olddata[15]) begin
			nextdata[47:40] = olddata[111:104] ^ olddata[79:72] ^ ((olddata[47:40]<<1)^8'b00011011) ^ (((olddata[15:8]<<1)^8'b00011011)^olddata[15:8]);
		end else if(olddata[47]) begin
			nextdata[47:40] = olddata[111:104] ^ olddata[79:72] ^ ((olddata[47:40]<<1)^8'b00011011) ^ (((olddata[15:8]<<1))^olddata[15:8]);
		end else if(olddata[15]) begin
			nextdata[47:40] = olddata[111:104] ^ olddata[79:72] ^ ((olddata[47:40]<<1)) ^ (((olddata[15:8]<<1)^8'b00011011)^olddata[15:8]);
		end else begin
			nextdata[47:40] = olddata[111:104] ^ olddata[79:72] ^ ((olddata[47:40]<<1)) ^ (((olddata[15:8]<<1))^olddata[15:8]);
		end

		if(olddata[39] && olddata[7]) begin
			nextdata[39:32] = olddata[103:96] ^ olddata[71:64] ^ ((olddata[39:32]<<1)^8'b00011011) ^ (((olddata[7:0]<<1)^8'b00011011)^olddata[7:0]);
		end else if(olddata[39]) begin
			nextdata[39:32] = olddata[103:96] ^ olddata[71:64] ^ ((olddata[39:32]<<1)^8'b00011011) ^ (((olddata[7:0]<<1))^olddata[7:0]);
		end else if(olddata[7]) begin
			nextdata[39:32] = olddata[103:96] ^ olddata[71:64] ^ ((olddata[39:32]<<1)) ^ (((olddata[7:0]<<1)^8'b00011011)^olddata[7:0]);
		end else begin
			nextdata[39:32] = olddata[103:96] ^ olddata[71:64] ^ ((olddata[39:32]<<1)) ^ (((olddata[7:0]<<1))^olddata[7:0]);
		end

		if(olddata[31] && olddata[127]) begin
			nextdata[31:24] = (((olddata[127:120]<<1)^8'b00011011)^olddata[127:120]) ^ olddata[95:88] ^ olddata[63:56] ^ ((olddata[31:24]<<1)^8'b00011011);
		end else if(olddata[31]) begin
			nextdata[31:24] = (((olddata[127:120]<<1))^olddata[127:120]) ^ olddata[95:88] ^ olddata[63:56] ^ ((olddata[31:24]<<1)^8'b00011011);
		end else if(olddata[127]) begin
			nextdata[31:24] = (((olddata[127:120]<<1)^8'b00011011)^olddata[127:120]) ^ olddata[95:88] ^ olddata[63:56] ^ ((olddata[31:24]<<1));
		end else begin
			nextdata[31:24] = (((olddata[127:120]<<1))^olddata[127:120]) ^ olddata[95:88] ^ olddata[63:56] ^ ((olddata[31:24]<<1));
		end

		if(olddata[23] && olddata[119]) begin
			nextdata[23:16] = (((olddata[119:112]<<1)^8'b00011011)^olddata[119:112]) ^ olddata[87:80] ^ olddata[55:48] ^ ((olddata[23:16]<<1)^8'b00011011);
		end else if(olddata[23]) begin
			nextdata[23:16] = (((olddata[119:112]<<1))^olddata[119:112]) ^ olddata[87:80] ^ olddata[55:48] ^ ((olddata[23:16]<<1)^8'b00011011);
		end else if(olddata[119]) begin
			nextdata[23:16] = (((olddata[119:112]<<1)^8'b00011011)^olddata[119:112]) ^ olddata[87:80] ^ olddata[55:48] ^ ((olddata[23:16]<<1));
		end else begin
			nextdata[23:16] = (((olddata[119:112]<<1))^olddata[119:112]) ^ olddata[87:80] ^ olddata[55:48] ^ ((olddata[23:16]<<1));
		end

		if(olddata[15] && olddata[111]) begin
			nextdata[15:8] = (((olddata[111:104]<<1)^8'b00011011)^olddata[111:104]) ^ olddata[79:72] ^ olddata[47:40] ^ ((olddata[15:8]<<1)^8'b00011011);
		end else if(olddata[15]) begin
			nextdata[15:8] = (((olddata[111:104]<<1))^olddata[111:104]) ^ olddata[79:72] ^ olddata[47:40] ^ ((olddata[15:8]<<1)^8'b00011011);
		end else if(olddata[111]) begin
			nextdata[15:8] = (((olddata[111:104]<<1)^8'b00011011)^olddata[111:104]) ^ olddata[79:72] ^ olddata[47:40] ^ ((olddata[15:8]<<1));
		end else begin
			nextdata[15:8] = (((olddata[111:104]<<1))^olddata[111:104]) ^ olddata[79:72] ^ olddata[47:40] ^ ((olddata[15:8]<<1));
		end

		if(olddata[7] && olddata[103]) begin //least significant byte
			nextdata[7:0] = (((olddata[103:96]<<1)^8'b00011011)^olddata[103:96]) ^ olddata[71:64] ^ olddata[39:32] ^ ((olddata[7:0]<<1)^8'b00011011);
		end else if(olddata[7]) begin
			nextdata[7:0] = (((olddata[103:96]<<1))^olddata[103:96]) ^ olddata[71:64] ^ olddata[39:32] ^ ((olddata[7:0]<<1)^8'b00011011);
		end else if(olddata[103]) begin
			nextdata[7:0] = (((olddata[103:96]<<1)^8'b00011011)^olddata[103:96]) ^ olddata[71:64] ^ olddata[39:32] ^ ((olddata[7:0]<<1));
		end else begin
			nextdata[7:0] = (((olddata[103:96]<<1))^olddata[103:96]) ^ olddata[71:64] ^ olddata[39:32] ^ ((olddata[7:0]<<1));
		end
		end else begin
			nextdata = currdata;
		end
	end
endmodule
