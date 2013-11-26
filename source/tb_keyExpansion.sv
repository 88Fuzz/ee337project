`timescale 1ns / 100ps

module tb_keyExpansion();

localparam CLKPERIOD=10;
localparam WAIT=5;

reg tb_clk;
reg tb_n_rst;
reg [3:0] tb_roundNum;
reg tb_enable;
reg tb_expansionDone;
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


keyExpansion DUT
(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .roundNum(tb_roundNum),
  .enable(tb_enable),
  .sramReadValue(tb_sramReadValue),
  .expansionDone(tb_expansionDone),
  .sramWriteValue(tb_sramWriteValue),
  .sramRead(tb_sramRead),
  .sramWrite(tb_sramWrite),
  .sramDump(tb_sramDump),
  .sramInit(tb_sramInit),
  .sramAddr(tb_sramAddr),
  .sramDumpNum(tb_sramDumpNum),
  .sramInitNum(tb_sramInitNum)
);

testing_sram sssssssssssssssssRAM
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

/*keyExpansion DUT(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .roundNum(tb_roundNum),
  .enable(tb_enable),
  .expansionDone(tb_expansionDone)
  );*/


always begin
  tb_clk=1;
  #(CLKPERIOD/2);
  tb_clk=0;
  #(CLKPERIOD/2);
end

initial begin
  #(WAIT);
  tb_realInitNum=0;
  tb_realDumpNum=2;
  tb_realDump=0;
  tb_n_rst=0;
  #(WAIT);
  tb_realInit=1;
  #(WAIT);
  tb_realInit=0;
  tb_n_rst=1;
  #(WAIT*4);
  tb_realDump=1;
  #(WAIT);
  tb_realDump=0;
  #(WAIT);
  #(WAIT/2);
  
  tb_roundNum=1;
  tb_enable=1;
  @(posedge tb_expansionDone);
  tb_enable=0;
  $display("HERE");
  tb_roundNum=2;
  tb_enable=1;
  @(posedge tb_expansionDone);
  tb_enable=0;
  $display("HERE2");
  
end
endmodule