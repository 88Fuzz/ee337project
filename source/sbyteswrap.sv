// $Id: $
// File name:   sbyteswrap.sv
// Created:     11/30/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Wrapper for sbytes

module sbyteswrap
(
	input wire clk,
	input wire n_rst,
	input wire sbytes_enable,
	//input wire [127:0] olddata,
	//output reg [127:0] newdata,
	output reg sbytes_finished,
	
	output reg sramwrite,
	output reg sramread,
	output reg [15:0]sramaddr, 
	output reg sramdump, 
	output reg [2:0]sramdumpnum, 
	output reg [2:0]sraminitnum, 
	output reg sraminit, 
	output reg [127:0]sramwrite_data, 
	input wire [127:0]sramread_data 
);

	typedef enum bit [5:0] {idle,readsram1,readsram2,readsram3, byte1s, byte1c, byte2s, byte2c, byte3s, byte3c, byte4s, byte4c, byte5s, byte5c, byte6s, byte6c, byte7s, byte7c, byte8s, byte8c, byte9s, byte9c, byte10s, byte10c, byte11s, byte11c, byte12s, byte12c, byte13s, byte13c, byte14s, byte14c, byte15s, byte15c, byte16s, byte16c, writesram1, writesram2, buff1, buff2, finito} stateType;
  stateType state, nextstate;

	reg [7:0] datasend;
	reg [7:0] datain;
	reg smallenable;
	
	reg [127:0] currolddata;
	reg [127:0] nextolddata; 
	
	reg [127:0] currnewdata;
	reg [127:0] nextnewdata; 
	

	always@(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			state <= idle;
			currnewdata <= 0; 
			currolddata <= 0; 
		end else begin
			state <= nextstate;
			currnewdata <= nextnewdata; 
			currolddata <= nextolddata; 
		end
	end

	sbytes DUT (.olddata(datasend), .newdata(datain));

	always@(state, sbytes_enable) begin
		nextstate = state;
		case(state)
			idle:
			begin
				if(sbytes_enable) begin
					nextstate = readsram1;
				end else begin
				  nextstate = state;
				end
			end
			readsram1:
			begin
			  nextstate = readsram2;
			end
			readsram2:
			begin
			  nextstate = readsram3;
			end 
			readsram3:
			begin
			  nextstate = byte1s; 
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
				nextstate = writesram1;
			end
			writesram1:
			begin
			  nextstate = writesram2; 
			end 
			writesram2:
			begin
			  nextstate = finito; 
			end 
			finito:
			begin
				nextstate = buff1;
			end
			buff1:
			begin
				nextstate = buff2;
			end
			buff2:
			begin
				nextstate = idle;
			end
			default:
			begin
			  nextstate = idle;
			end
		endcase
	end

	always@(state, sbytes_enable, sramread_data, currolddata, currnewdata, datain) begin
		smallenable = 1'b0;
		sbytes_finished = 1'b0;
		case(state)
			idle:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				smallenable = 0;
				datasend = 0;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			readsram1:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 32;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				smallenable = 0;
				datasend = 0;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			readsram2: 
			begin
			  sramread = 1;
			  sramwrite = 0;
			  sramaddr = 32;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				smallenable = 0;
				datasend = 0;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			readsram3: 
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = sramread_data; 
				smallenable = 0;
				datasend = 0;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end 
			byte1s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[7:0];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte1c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[7:0];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:8],datain};
				sbytes_finished = 0;
			end
			byte2s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[15:8];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte2c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[15:8];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:16],datain,currnewdata[7:0]};
				sbytes_finished = 0;
			end
			byte3s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[23:16];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte3c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[23:16];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:24],datain,currnewdata[15:0]};
				sbytes_finished = 0;
			end
			byte4s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[31:24];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte4c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[31:24];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:32],datain,currnewdata[23:0]};
				sbytes_finished = 0;
			end
			byte5s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[39:32];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte5c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[39:32];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:40],datain,currnewdata[31:0]};
				sbytes_finished = 0;
			end
			byte6s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[47:40];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte6c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[47:40];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:48],datain,currnewdata[39:0]};
				sbytes_finished = 0;
			end
			byte7s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[55:48];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte7c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[55:48];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:56],datain,currnewdata[47:0]};
				sbytes_finished = 0;
			end
			byte8s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[63:56];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte8c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[63:56];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:64],datain,currnewdata[55:0]};
				sbytes_finished = 0;
			end
			byte9s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[71:64];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte9c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[71:64];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:72],datain,currnewdata[63:0]};
				sbytes_finished = 0;
			end
			byte10s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[79:72];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte10c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[79:72];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:80],datain,currnewdata[71:0]};
				sbytes_finished = 0;
			end
			byte11s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[87:80];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte11c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[87:80];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:88],datain,currnewdata[79:0]};
				sbytes_finished = 0;
			end
			byte12s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[95:88];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte12c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[95:88];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:96],datain,currnewdata[87:0]};
				sbytes_finished = 0;
			end
			byte13s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[103:96];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte13c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[103:96];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:104],datain,currnewdata[95:0]};
				sbytes_finished = 0;
			end
			byte14s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[111:104];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte14c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[111:104];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:112],datain,currnewdata[103:0]};
				sbytes_finished = 0;
			end
			byte15s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[119:112];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte15c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[119:112];
				smallenable = 1'b1;
				nextnewdata = {currnewdata[127:120],datain,currnewdata[111:0]};
				sbytes_finished = 0;
			end
			byte16s:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				datasend = currolddata[127:120];
				smallenable = 1'b1;
				nextnewdata = currnewdata ;
				sbytes_finished = 0;
			end
			byte16c:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
			  datasend = currolddata[127:120];
				smallenable = 1'b1;
				nextnewdata = {datain,currnewdata[119:0]};
				sbytes_finished = 0;
			end
			writesram1:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 32;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				smallenable = 0;
				datasend = 0;
				nextnewdata = currnewdata ;
				sbytes_finished = 1'b0;
			end
			writesram2:
			begin
			  sramread = 0;
			  sramwrite = 1;
			  sramaddr = 32;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = currnewdata; 
			  nextolddata = currolddata; 
				smallenable = 0;
				datasend = 0;
				nextnewdata = currnewdata ;
				sbytes_finished = 1'b0;
			end
			finito:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextolddata = currolddata; 
				smallenable = 0;
				datasend = 0;
				nextnewdata = currnewdata ;
				sbytes_finished = 1'b1;
			end
			default:
			begin
			sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = currnewdata; 
			  nextolddata = currolddata; 
				smallenable = 0;
				datasend = 0;
				nextnewdata = currnewdata ;
				sbytes_finished = 1'b0; 
			end 
		endcase
	end
endmodule
