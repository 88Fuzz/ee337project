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
	input wire HSELx,
	input wire mWrite,
	input wire mRead,
	input wire [127:0] origkey,
	input wire [127:0] olddata,
	output reg [127:0] newdata,
	output reg HREADYOUT
);

	controller controller
	(
		.clk(clk),
		.n_rst(n_rst),
		.addrMatch(addrMatch),
		.HSELx(HSELx),
		.mWrite(mWrite),
		.dataReady(dataReady),
		.mRead(mRead),
		.finished(finished),
		.keyexp_finished(keyexp_finished),
		.sbytes_finished(sbytes_finished),
		.srows_finished(srows_finished),
		.mcol_finished(mcol_finished),
		.around_finished(around_finished),
		.HREADYOUT(HREADYOUT),
		.readk_enable(readk_enable),
		.read_enable(read_enable),
		.write_enable(write_enable),
		.keyexp_enable(keyexp_enable),
		.sbytes_enable(sbytes_enable),
		.srows_enable(srows_enable),
		.mcol_enable(mcol_enable),
		.around_enable(around_enable)
	);

	keyExpansion keyExpansion
	(
		.clk(clk),
  		.n_rst(n_rst),
  		.roundNum(roundNum),
  		.enable(enable),
  		.sramReadValue(sramReadValue),
  		.expansionDone(expansionDone),
  		.sramWriteValue(sramWriteValue),
  		.sramRead(sramRead),
  		.sramWrite(sramWrite),
  		.sramDump(sramDump),
  		.sramInit(sramInit),
  		.sramAddr(sramAddr),
  		.sramDumpNum(sramDumpNum),
  		.sramInitNum(sramInitNum)
	);

	sbyteswrap sbyteswrap
	(
		.clk(clk),
		.n_rst(n_rst),
		.sbytes_enable(sbytes_enable),
		.olddata(olddata),
		.newdata(newdata),
		.sbytes_finished(sbytes_finished)
	);

	mixcol mixcol
	(
		.mixcol_enable(mixcol_enable),
		.olddata(olddata),
		.newdata(newdata),
		.mixcol_finished(mixcol_finished)
	);

	aroundwrap aroundwrap
	(
		.clk(clk),
		.n_rst(n_rst),
		.around_enable(around_enable),
		.subkey(subkey),
		.olddata(olddata),
		.newdata(newdata),
		.around_finished(around_finished)
	);

	
