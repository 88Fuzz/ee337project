`timescale 1ns / 100ps

module tb_aroundwrap();

localparam CLKPERIOD=10;
localparam WAIT=5;

reg tb_clk;
reg tb_n_rst;
reg tb_around_enable; 
reg tb_around_finished; 
reg [127:0] tb_sramReadValue;
reg [127:0] tb_sramWriteValue;
reg tb_sramRead;
reg tb_sramWrite;
reg tb_sramDump;
reg tb_sramInit;
reg [15:0] tb_sramAddr;
reg [2:0] tb_sramDumpNum;
reg [2:0] tb_sramInitNum;
reg tb_realInit;
reg tb_realDump;
reg [2:0] tb_realDumpNum;
reg [2:0] tb_realInitNum;
reg [127:0]tb_expected;

aroundwrap DUT
(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .around_enable(tb_around_enable),
  .around_finished(tb_around_finished),
  .sramReadValue(tb_sramReadValue),
  .sramWriteValue(tb_sramWriteValue),
  .sramRead(tb_sramRead),
  .sramWrite(tb_sramWrite),
  .sramDump(tb_sramDump),
  .sramInit(tb_sramInit),
  .sramAddr(tb_sramAddr),
  .sramDumpNum(tb_sramDumpNum),
  .sramInitNum(tb_sramInitNum)
);

testing_sram spamRAM
(
  .read(tb_sramRead),
  .write(tb_sramWrite),
  .addr(tb_sramAddr),
  .dump(tb_realDump),
  .dumpNum(tb_realDumpNum),
  .initNum(tb_realInitNum),
  .init(tb_realInit),
  .write_data(tb_sramWriteValue),
  .read_data(tb_sramReadValue)
);

always begin
  tb_clk=1;
  #(CLKPERIOD/2);
  tb_clk=0;
  #(CLKPERIOD/2);
end

