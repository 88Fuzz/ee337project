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
	output reg around_finished,
	
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

	typedef enum bit [7:0] {idle,readsramkey1, readsramkey2, readsramkey3, readsramdata1 , readsramdata2, readsramdata3, byte1s, byte1c, byte2s, byte2c, byte3s, byte3c, byte4s, byte4c, byte5s, byte5c, byte6s, byte6c, byte7s, byte7c, byte8s, byte8c, byte9s, byte9c, byte10s, byte10c, byte11s, byte11c, byte12s, byte12c, byte13s, byte13c, byte14s, byte14c, byte15s, byte15c, byte16s, byte16c, writesram1, writesram2, finito}stateType;
	stateType state, nextstate;

	reg [127:0] datahold;
	reg [7:0] datasend;
	reg [7:0] datain;
	reg [7:0] keysend;
	reg smallenable;
	 
	
	reg [127:0] currsubkey;
	reg [127:0] nextsubkey;
	
	reg [127:0] currolddata;
	reg [127:0] nextolddata;

	
	reg [127:0]currNewData;
	reg [127:0]nextNewData; 

	always@(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			state <= idle;
			currNewData <= 0; 
			currsubkey <= 0; 
			currolddata <= 0; 
			
		end else begin
			state <= nextstate;
			currNewData <= nextNewData; 
			currolddata <= nextolddata; 
			currsubkey <= nextsubkey; 
		end
	end

	addround DUT(.n_rst(n_rst), .around_enable(smallenable), .subkey(keysend), .olddata(datasend), .newdata(datain));

	always@(state) begin
		nextstate = state;
		case(state)
			idle:
			begin
				if(around_enable == 1'b1) begin
					nextstate = readsramkey1;
				end
			end
			
			readsramkey1:
			begin
			  nextstate = readsramkey2;
			end 
			readsramkey2:
			begin 
			  nextstate = readsramkey3;
			end
			readsramkey3:
			begin  
			   nextstate = readsramdata1;
			end 
			readsramdata1: 
			begin
			   nextstate = readsramdata2;
			end 
			readsramdata2: 
			begin
			   nextstate = readsramdata3;
			end 
			readsramdata3: 
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
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0;
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata; 
				smallenable = 0;
				keysend = 0;
				datasend = 0;
				nextNewData = currNewData ;
			end 
				
			readsramkey1:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 16;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0;
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata; 
			  smallenable = 0;
				keysend = 0;
				datasend = 0;	
				nextNewData = currNewData ;		     
			end
			
			readsramkey2:
			begin
			  sramread = 1;
			  sramwrite = 0;
			  sramaddr = 16;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0;
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata; 
			  smallenable = 0;
				keysend = 0;
				datasend = 0;
				nextNewData = currNewData ;    
			end
			
			readsramkey3:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextsubkey = sramread_data; 
			  nextolddata = currolddata; 
			  smallenable = 0;
				keysend = 0;
				datasend = 0;
				nextNewData = currNewData ;    
			end 
			
			readsramdata1:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 32;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0;
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;  
			  smallenable = 0;
				keysend = 0;
				datasend = 0; 
				nextNewData = currNewData ;  
			end
			
			readsramdata2:
			begin
			  sramread = 1;
			  sramwrite = 0;
			  sramaddr = 32;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0;
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata; 
			  smallenable = 0;
				keysend = 0;
				datasend = 0; 
				nextNewData = currNewData ;   
			end
			
			readsramdata3:
			begin
			  sramread = 0;
			  sramwrite = 0;
			  sramaddr = 0;
			  sramdump = 0; 
			  sramdumpnum = 0; 
			  sraminitnum = 0; 
			  sraminit = 0;
			  sramwrite_data = 0; 
			  nextsubkey = currsubkey;  
			  nextolddata = sramread_data;  
			  smallenable = 0;
				keysend = 0;
				datasend = 0; 
				nextNewData = currNewData ;  
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[7:0];
				datasend = currolddata[7:0];
				smallenable = 1'b1;
				nextNewData = currNewData ; 
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[7:0];
				datasend = currolddata[7:0];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:8],datain}; 
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[15:8];
				datasend = currolddata[15:8];
				smallenable = 1'b1;
				nextNewData = currNewData; 
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[15:8];
				datasend = currolddata[15:8];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:16],datain,currNewData[7:0]}; 
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[23:16];
				datasend = currolddata[23:16];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[23:16];
				datasend = currolddata[23:16];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:24],datain,currNewData[15:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[31:24];
				datasend = currolddata[31:24];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[31:24];
				datasend = currolddata[31:24];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:32],datain,currNewData[23:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[39:32];
				datasend = currolddata[39:32];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[39:32];
				datasend = currolddata[39:32];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:40],datain,currNewData[31:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[47:40];
				datasend = currolddata[47:40];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[47:40];
				datasend = currolddata[47:40];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:48],datain,currNewData[39:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[55:48];
				datasend = currolddata[55:48];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[55:48];
				datasend = currolddata[55:48];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:56],datain,currNewData[47:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[63:56];
				datasend = currolddata[63:56];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[63:56];
				datasend = currolddata[63:56];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:64],datain,currNewData[55:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[71:64];
				datasend = currolddata[71:64];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[71:64];
				datasend = currolddata[71:64];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:72],datain,currNewData[63:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[79:72];
				datasend = currolddata[79:72];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[79:72];
				datasend = currolddata[79:72];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:80],datain,currNewData[71:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[87:80];
				datasend = currolddata[87:80];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[87:80];
				datasend = currolddata[87:80];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:88],datain,currNewData[79:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[95:88];
				datasend = currolddata[95:88];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[95:88];
				datasend = currolddata[95:88];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:96],datain,currNewData[87:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[103:96];
				datasend = currolddata[103:96];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[103:96];
				datasend = currolddata[103:96];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:104],datain,currNewData[95:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[111:104];
				datasend = currolddata[111:104];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[111:104];
				datasend = currolddata[111:104];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:112],datain,currNewData[103:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[119:112];
				datasend = currolddata[119:112];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[119:112];
				datasend = currolddata[119:112];
				smallenable = 1'b1;
				nextNewData = {currNewData[127:120],datain,currNewData[111:0]};
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
				keysend = currsubkey[127:120];
				datasend = currolddata[127:120];
				smallenable = 1'b1;
				nextNewData = currNewData;
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
			  nextsubkey = currsubkey; 
			  nextolddata = currolddata;
			  keysend = currsubkey[127:120];
				datasend = currolddata[127:120];
				smallenable = 1'b1;
				nextNewData = {datain,currNewData[119:0]};
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
			  sramwrite_data = currNewData; 
			  nextsubkey = currsubkey;
			  nextolddata = currolddata; 
			  keysend = 0; 
			  datasend  = 0; 
			  smallenable = 0; 
			  nextNewData = currNewData; 
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
			  sramwrite_data = currNewData; 
			  nextsubkey = currsubkey;
			  nextolddata = currolddata; 
			  keysend = 0; 
			  datasend  = 0; 
			  smallenable = 0; 
			  nextNewData = currNewData; 
		  end 
			  
			finito:
			begin
				around_finished = 1'b1;
			end
		endcase
	end		
endmodule
