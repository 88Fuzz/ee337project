// $Id: $
// File name:   AES.sv
// Created:     12/1/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Top Level Wrapper

module AES
(
	input wire clk,
	input wire n_rst,
	input wire [31:0] HADDR,
	input wire [2:0] HBURST,
	input wire HMASTLOCK,
	input wire [3:0] HPROT,
	input wire [2:0] HSIZE,
	input wire [1:0] HTRANS,
	input wire [127:0] HWDATA,
	input wire HWRITE,
	input wire HSELx,
	input wire HREADY,
	output reg HRESP,
	output reg [127:0] HRDATA,
	output reg HREADYOUT
);







//top level sram signals
wire sramBigReadEnable;
wire sramBigWriteEnable;
wire [127:0]sramBigWriteValue;
wire [127:0]sramBigReadValue;
wire [15:0]sramBigAddr;
wire sramBigDump;
wire [2:0]sramBigDumpNum;
wire [2:0]sramBigInitNum;
wire sramBigInit;


//keyexpansion sram signals
wire [127:0]sramWriteValue_keyexp;
wire sramRead_keyexp;
wire sramWrite_keyexp;
wire sramDump_keyexp;
wire sramInit_keyexp;
wire [15:0]sramAddr_keyexp;
wire [2:0]sramDumpNum_keyexp;
wire [2:0]sramInitNum_keyexp;


//aroundwrap sram signals		
wire [127:0]sramWrite_around;
wire sramRead_around;
wire [15:0]sramAddr_around;
wire sramDump_around;
wire [2:0]sramDumpNum_around;
wire [2:0]sramInitNum_around;
wire sramInit_around;
wire sramWriteValue_around;

//sbyteswrap sram signals
wire [127:0]sramWrite_sbytes;
wire sramRead_sbytes;
wire [15:0]sramAddr_sbytes;
wire sramDump_sbytes;
wire [2:0]sramDumpNum_sbytes;
wire [2:0]sramInitNum_sbytes;
wire sramInit_sbytes;
wire sramWriteValue_sbytes;

//mixcolumn sram signals
wire [127:0]sramWrite_mcol;
wire sramRead_mcol;
wire [15:0]sramAddr_mcol;
wire sramDump_mcol;
wire [2:0]sramDumpNum_mcol;
wire [2:0]sramInitNum_mcol;
wire sramInit_mcol;
wire sramWriteValue_mcol;

//srows sram signals
wire [127:0]sramWrite_srows;
wire sramRead_srows;
wire [15:0]sramAddr_srows;
wire sramDump_srows;
wire [2:0]sramDumpNum_srows;
wire [2:0]sramInitNum_srows;
wire sramInit_srows;
wire sramWriteValue_srows;


//wire [31:0]HADDR;
//wire [2:0]HBURST;
//wire HMASTLOCK;
//wire [3:0] HPORT;
//wire [2:0] HSIZE;
//wire [1:0] HTRANS;
//wire HWRITE;//high=write, low=read
//wire HSELx;
//wire HREADY;
wire addrMatch;
wire mWrite;
wire mRead;
wire dataReady;
wire invalid;



wire readk_enable;//master writing key
wire read_enable;//master writing data
wire write_enable;//master reading data
wire hready_enable;
//AMBA_inout sram signals
wire [127:0]sramWriteValue_AMBA;
wire sramRead_AMBA;
wire sramWrite_AMBA;
wire [15:0]sramAddr_AMBA;
wire sramDump_ADDR;
wire [2:0]sramDumpNum_AMBA;
wire [2:0]sramInitNum_AMBA;
wire sramInit_AMBA;








assign sramBigDump=0;
assign sramBigDumpNum=0;
assign sramBigInitNum=0;
assign sramBigInit=0;
assign sramBigAddr=sramAddr_AMBA|sramAddr_srows|sramAddr_mcol|sramAddr_sbytes|sramAddr_around|sramAddr_keyexp;
assign sramBigReadEnable=sramRead_AMBA|sramRead_srows|sramRead_mcol|sramRead_sbytes|sramRead_around|sramRead_keyexp;
assign sramBigWriteEnable=sramWrite_AMBA|sramWrite_srows|sramWrite_mcol|sramWrite_sbytes|sramWrite_around|sramWrite_keyexp;
assign sramBigWriteValue=sramWriteValue_AMBA|sramWriteValue_srows|sramWriteValue_mcol|sramWriteValue_sbytes|sramWriteValue_around|sramWriteValue_keyexp;


	controller controller
	(
		.clk(clk),
		.n_rst(n_rst),
		.addrMatch(addrMatch),
		.HSELx(HSELx),
		.mWrite(mWrite),
		.dataReady(dataReady),
		.mRead(mRead),
		//.finished(finished),
		.keyexp_finished(keyexp_finished),
		.sbytes_finished(sbytes_finished),
		.srows_finished(srows_finished),
		.mcol_finished(mcol_finished),
		.around_finished(around_finished),
		.invalid(invalid),
		.HREADYOUT(hready_enable),
		.readk_enable(readk_enable),
		.read_enable(read_enable),
		.write_enable(write_enable),
		.keyexp_enable(keyexp_enable),
		.sbytes_enable(sbytes_enable),
		.srows_enable(srows_enable),
		.mcol_enable(mcol_enable),
		.around_enable(around_enable),
		.hresp_error(hresp_error),
		.roundnum(roundnum)
	);
	
	


	keyExpansion keyExpansion
	(
	  //INPUTS
		.clk(clk),
  		.n_rst(n_rst),
  		.roundNum(roundnum),
  		.enable(keyexp_enable),
  		.sramReadValue(sramBigReadValue),
  		//OUTPUTS
  		.expansionDone(keyexp_finished),
  		.sramWriteValue(sramWriteValue_keyexp),
  		.sramRead(sramRead_keyexp),
  		.sramWrite(sramWrite_keyexp),
  		.sramDump(sramDump_keyexp),
  		.sramInit(sramInit_keyexp),
  		.sramAddr(sramAddr_keyexp),
  		.sramDumpNum(sramDumpNum_keyexp),
  		.sramInitNum(sramInitNum_keyexp)
	);
	
	

	sbyteswrap sbyteswrap
	(
	  //INPUTES
		.clk(clk),
		.n_rst(n_rst),
		.sbytes_enable(sbytes_enable),
sramBigReadValue),
		//OUTPUTS
sramWrite_sbytes),
sramRead_sbytes),
sramAddr_sbytes),
sramDump_sbytes),
sramDumpNum_sbytes),
sramInitNum_sbytes),
sramInit_sbytes),
sramWriteValue_sbytes),
		.sbytes_finished(sbytes_finished)
	);

	mixcol mixcol
	(
	  //INPUT
	  .clk(clk),
	  .n_rst(n_rst),
		.mixcol_enable(mcol_enable),
sramBigReadValue),
		//OUTPUT
sramWrite_mcol),
sramRead_mcol),
sramAddr_mcol),
sramDump_mcol),
sramDumpNum_mcol),
sramInitNum_mcol),
sramInit_mcol),
sramWriteValue_mcol),
		.mixcol_finished(mcol_finished)
	);
	
	shiftrows?????
	(
	  //INPUT
	  .clk(clk),
	  .n_rst(n_rst),
	  .srows_enable(srows_enable),
sramBigReadValue),
	  //OUTPUT
sramWrite_srows),
sramRead_srows),
sramAddr_srows),
sramDump_srows),
sramDumpNum_srows),
sramInitNum_srows),
sramInit_srows),
sramWriteValue_srows),
	  .srows_finished(srows_finished)
	);

	aroundwrap aroundwrap
	(
	  //INPUTS
		.clk(clk),
		.n_rst(n_rst),
		.around_enable(around_enable),
    .sramread_data(sramBigReadValue),		
		//OUTPUTS
    .sramwrite(sramWrite_around),
    .sramread(sramRead_around),
    .sramaddr(sramAddr_around),
    .sramdump(sramDump_around),
    .sramdumpnum(sramDumpNum_around),
    .sraminitnum(sramInitNum_around),
    .sraminit(sramInit_around),
    .sramwrite_data(sramWriteValue_around),
		.around_finished(around_finished)
	);
  
	AMBAsensor AMBAsensor
 (
  .HADDR(HADDR),
  .HBURST(HBURST),
  .HMASTLOCK(HMASTLOCK),
  .HPORT(HPORT),
  .HSIZE(HSIZE),
  .HTRANS(HTRANS),
  .HWRITE(HWRITE),//high=write, low=read
  .HSELx(HSELx),
  .HREADY(HREAD),
  .addrMatch(addrMatch),
  .mWrite(mWrite),
  .mRead(mRead),
  .dataReady(dataReady),
  .invalid(invalid)
 );

  AMBA_inout AMBA_inout
  (
  input wire clk(clk),
  input wire n_rst(n_rst),
  input wire writek_enable(readk_enable),//master writing key
  input wire writed_enable(read_enable),//master writing data
  input wire readd_enable(write_enable),//master reading data
  input wire hresp_error(invalid),
  input wire hready_enable(hready_enable),
  input wire [127:0] read_data(sramBigReadValue),
  input wire [127:0] HWDATA(HWDATA),
  output reg [127:0] HRDATA(HRDATA),
  output reg [127:0] write_data(sramWriteValue_AMBA),
  output reg HREADYOUT(HREADYOUT),
  output reg HRESP(HRESP),
  output reg read(sramRead_AMBA),
  output reg write(sramWrite_AMBA),
  output reg [15:0] addr(sramAddr_AMBA),
  output reg dump(sramDump_ADDR),
  output reg [2:0] dumpNum(sramDumpNum_AMBA),
  output reg [2:0] initNum(sramInitNum_AMBA),
  output reg init(sramInit_AMBA)
  );


  testing_sram testing_sram
  (
  input wire read(sramBigReadEnable),
  input wire write(sramBigWriteEnable),
  input wire [15:0] addr(sramBigAddr),
  input wire dump(sramBigDump),
  input wire [2:0] dumpNum(sramBigDumpNum),
  input wire [2:0] initNum(sramBigInitNum),
  input wire init(sramBigInit),
  input wire [127:0] write_data(sramBigWriteValue),
  output wire [127:0] read_data(sramBigReadValue)
  );