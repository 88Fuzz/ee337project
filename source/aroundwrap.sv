// $Id: $
// File name:   aroundwrap.sv
// Created:     11/29/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Wrapper to make sure Add Round Key is called the correct number of times

module aroundwrap
(
	input wire clk,
	input wire n_rst,
	input wire around_enable,
	input wire [127:0] subkey,
	input wire [127:0] olddata,
	output reg [127:0] newdata,
	output reg around_finished
);

	typedef enum bit [7:0] {idle, byte1s, byte1c, byte2s, byte2c, byte3s, byte3c, byte4s, byte4c, byte5s, byte5c, byte6s, byte6c, byte7s, byte7c, byte8s, byte8c, byte9s, byte9c, byte10s, byte10c, byte11s, byte11c, byte12s, byte12c, byte13s, byte13c, byte14s, byte14c, byte15s, byte15c, byte16s, byte16c, finito};
	stateType state, nextstate;

	reg [127:0] datahold;
	reg [7:0] datasend;
	reg [7:0] datain;
	reg [7:0] keysend;
	reg smallenable;

	always@(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			newdata <= olddata;
			state <= idle;
		end else begin
			state <= nextstate;
		end
	end

	addround DUT(n_rst(n_rst), around_enable(smallenable), subkey(keysend), olddata(datasend), newdata(datain));

	always@(state) begin
		nextstate = state;
		case(state)
			idle:
			begin
				if(around_enable == 1'b1) begin
					nextstate = byte1s;
				end
			end
			byte1s:
			begin
				nextstate = byte1c;
			end
			byte1c:
			begin
				nextstate = byte2s;
			end
			byte2s:
			begin
				nextstate = byte2c;
			end
			byte2c:
			begin
				nextstate = byte3s;
			end
			byte3s:
			begin
				nextstate = byte3c;
			end
			byte3c:
			begin
				nextstate = byte4s;
			end
			byte4s:
			begin
				nextstate = byte4c;
			end
			byte4c:
			begin
				nextstate = byte5s;
			end
			byte5s:
			begin
				nextstate = byte5c;
			end
			byte5c:
			begin
				nextstate = byte6s;
			end
			byte6s:
			begin
				nextstate = byte6c;
			end
			byte6c:
			begin
				nextstate = byte7s;
			end
			byte7s:
			begin
				nextstate = byte7c;
			end
			byte7c:
			begin
				nextstate = byte8s;
			end
			byte8s:
			begin
				nextstate = byte8c;
			end
			byte8c:
			begin
				nextstate = byte9s;
			end
			byte9s:
			begin
				nextstate = byte9c;
			end
			byte9c:
			begin
				nextstate = byte10s;
			end
			byte10s:
			begin
				nextstate = byte10c;
			end
			byte10c:
			begin
				nextstate = byte11s;
			end
			byte11s:
			begin
				nextstate = byte11c;
			end
			byte11c:
			begin
				nextstate = byte12s;
			end
			byte12s:
			begin
				nextstate = byte12c;
			end
			byte12c:
			begin
				nextstate = byte13s;
			end
			byte13s:
			begin
				nextstate = byte13c;
			end
			byte13c:
			begin
				nextstate = byte14s;
			end
			byte14s:
			begin
				nextstate = byte14c;
			end
			byte14c:
			begin
				nextstate = byte15s;
			end
			byte15s:
			begin
				nextstate = byte15c;
			end
			byte15c:
			begin
				nextstate = byte16s;
			end
			byte16s:
			begin
				nextstate = byte16c;
			end
			byte16c:
			begin
				nextstate = finito;
			end
			finito:
			begin
				nextstate = idle;
			end
		endcase
	end


	always@(state) begin
		smallenable = 1'b1;
		around_finished = 1'b0;
		case(state)
			idle:
			begin
				smallenable = 1'b0;
				keysend = '0;
				datasend = '0;
			byte1s:
			begin
				keysend = subkey[7:0];
				datasend = olddata[7:0];
				smallenable = 1'b1;
			end
			byte1c:
			begin
				newdata[7:0] = datain;
			end
			byte2s:
			begin
				keysend = subkey[15:8];
				datasend = olddata[15:8];
				smallenable = 1'b1;
			end
			byte2c:
			begin
				newdata[15:8] = datain;
			end
			byte3s:
			begin
				keysend = subkey[23:16];
				datasend = olddata[23:16];
				smallenable = 1'b1;
			end
			byte3c:
			begin
				newdata[23:16] = datain;
			end
			byte4s:
			begin
				keysend = subkey[31:24];
				datasend = olddata[31:24];
				smallenable = 1'b1;
			end
			byte4c:
			begin
				newdata[31:24] = datain;
			end
			byte5s:
			begin
				keysend = subkey[39:32];
				datasend = olddata[39:32];
				smallenable = 1'b1;
			end
			byte5c:
			begin
				newdata[39:32] = datain;
			end
			byte6s:
			begin
				keysend = subkey[47:40];
				datasend = olddata[47:40];
				smallenable = 1'b1;
			end
			byte6c:
			begin
				newdata[47:40] = datain;
			end
			byte7s:
			begin
				keysend = subkey[55:48];
				datasend = olddata[55:48];
				smallenable = 1'b1;
			end
			byte7c:
			begin
				newdata[55:48] = datain;
			end
			byte8s:
			begin
				keysend = subkey[63:56];
				datasend = olddata[63:56];
				smallenable = 1'b1;
			end
			byte8c:
			begin
				newdata[63:56] = datain;
			end
			byte9s:
			begin
				keysend = subkey[71:64];
				datasend = olddata[71:64];
				smallenable = 1'b1;
			end
			byte9c:
			begin
				newdata[71:64] = datain;
			end
			byte10s:
			begin
				keysend = subkey[79:72];
				datasend = olddata[79:72];
				smallenable = 1'b1;
			end
			byte10c:
			begin
				newdata[79:72] = datain;
			end
			byte11s:
			begin
				keysend = subkey[87:80];
				datasend = olddata[87:80];
				smallenable = 1'b1;
			end
			byte11c:
			begin
				newdata[87:80] = datain;
			end
			byte12s:
			begin
				keysend = subkey[95:88];
				datasend = olddata[95:88];
				smallenable = 1'b1;
			end
			byte12c:
			begin
				newdata[95:88] = datain;
			end
			byte13s:
			begin
				keysend = subkey[103:96];
				datasend = olddata[103:96];
				smallenable = 1'b1;
			end
			byte13c:
			begin
				newdata[103:96] = datain;
			end
			byte14s:
			begin
				keysend = subkey[111:104];
				datasend = olddata[111:104];
				smallenable = 1'b1;
			end
			byte14c:
			begin
				newdata[111:104] = datain;
			end
			byte15s:
			begin
				keysend = subkey[119:112];
				datasend = olddata[119:112];
				smallenable = 1'b1;
			end
			byte15c:
			begin
				newdata[119:112] = datain;
			end
			byte16s:
			begin
				keysend = subkey[127:120];
				datasend = olddata[127:120];
				smallenable = 1'b1;
			end
			byte16c:
			begin
				newdata[127:120] = datain;
			end
			finito:
			begin
				around_finished = 1'b1;
			end
		endcase
	end		
endmodule
