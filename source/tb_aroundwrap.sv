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
  .sramread_data(tb_sramReadValue),
  .sramwrite_data(tb_sramWriteValue),
  .sramread(tb_sramRead),
  .sramwrite(tb_sramWrite),
  .sramdump(tb_sramDump),
  .sraminit(tb_sramInit),
  .sramaddr(tb_sramAddr),
  .sramdumpnum(tb_sramDumpNum),
  .sraminitnum(tb_sramInitNum)
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

initial begin
  #(WAIT);
  tb_realInitNum=2;
  tb_realDumpNum=0;
  tb_realDump=0;
  tb_n_rst=0;
  #(WAIT);
  tb_realInit=1;
  #(WAIT);
  tb_realInit=0;
  tb_n_rst=1;
  #(WAIT*4);
  tb_realDump=0;
  #(WAIT);
  tb_realDump=0;
  #(WAIT);
  #(WAIT/2);
  
  
  tb_around_enable=1;
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h08_48_F8_E9_2A_8D_C6_9A_2B_E2_F4_A0_BE_E3_3D_19; 
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round works!");
  else
    $error("round  no works!");
end 

endmodule   
  