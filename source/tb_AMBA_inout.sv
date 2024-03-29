`timescale 1ns / 100ps

module tb_AMBA_inout();

localparam CLKPERIOD=10;
localparam WAIT=5;

reg tb_clk;
reg tb_n_rst;
reg tb_writek_enable;
reg tb_writed_enable;
reg tb_readd_enable;
reg tb_hresp_error;
reg tb_hready_enable;
reg [127:0]tb_HWDATA;
reg [127:0]tb_HRDATA;
reg [127:0]tb_sramReadValue;
reg [127:0]tb_sramWriteValue;
reg tb_HREADYOUT;
reg tb_HRESP;
reg tb_sramRead;
reg tb_sramWrite;
reg [15:0]tb_sramAddr;

reg tb_dump;
reg [2:0]tb_dumpNum;
reg [2:0]tb_initNum;
reg tb_init;
reg [2:0]tb_realDumpNum;
reg [2:0]tb_realInitNum;
reg tb_realDump;
reg tb_realInit;

AMBA_inout DUT
(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .writek_enable(tb_writek_enable),//master writing key
  .writed_enable(tb_writed_enable),//master writing data
  .readd_enable(tb_readd_enable),//master reading data
  .hresp_error(tb_hresp_error),
  .hready_enable(tb_hready_enable),
  .read_data(tb_sramReadValue),
  .HWDATA(tb_HWDATA),
  //output
  .write_data(tb_sramWriteValue),
  .HRDATA(tb_HRDATA),
  .HREADYOUT(tb_HREADYOUT),
  .HRESP(tb_HRESP),
  .read(tb_sramRead),
  .write(tb_sramWrite),
  .addr(tb_sramAddr),
  .dump(tb_dump),
  .dumpNum(tb_dumpNum),
  .initNum(tb_initNum),
  .init(tb_init)
);

testing_sram sexRAM
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
  tb_realInit=0;
  tb_realDump=0;
  tb_realDumpNum=0;
  tb_realInitNum=0;
  tb_writek_enable=0;
  tb_writed_enable=0;
  tb_readd_enable=0;
  tb_hresp_error=0;
  tb_hready_enable=0;
  #(WAIT);
  tb_n_rst=0;
  #(WAIT*3);
  
  tb_n_rst=1;
  #(WAIT/2);
  #(CLKPERIOD);
  
  
  #(WAIT/4);
  tb_hresp_error=1;
  #(CLKPERIOD);
  
  if(tb_HRESP)
    $display("HRESP is asserted correctly");
  else
    $error("HRESP is not asserted correctly");
  
  tb_hresp_error=0;
  
  #(CLKPERIOD);
  
  if(!tb_HRESP)
    $display("HRESP is un-asserted correctly");
  else
    $error("HRESP is not un-asserted correctly");
  
  #(CLKPERIOD);
  #(CLKPERIOD);
  tb_hready_enable=1;
  #(CLKPERIOD);
  #(CLKPERIOD);
  #(CLKPERIOD);
  
  if(tb_HREADYOUT==0)
    $display("HRADYOUT is un-asserted correctly");
  else
    $error("HRADYOUT is not un-asserted correctly");
  
  tb_hready_enable=0;
  
  #(CLKPERIOD);
  #(WAIT*2);
  
  if(tb_HREADYOUT)
    $display("HRADYOUT is asserted correctly");
  else
    $error("HRADYOUT is not asserted correctly");
    
  tb_HWDATA=128'h09_CF_4F_3C__AB_F7_15_88__28_AE_D2_A6__2B_7E_15_16;
  
  tb_writek_enable=1;
  @(posedge tb_sramWrite);
  tb_writek_enable=0;
  if(tb_sramAddr==0)
    $display("Key write address correct");
  else
    $error("key write address incorrect");
    
  if(tb_sramWriteValue==tb_HWDATA)
    $display("key is writing correct value");
  else
    $error("key is writing incorrect value");
  
  
  tb_HWDATA=128'hAA_F4_3D_DD__A2_21_00_EF__87_66_45_0A__B4_32_11_76;
  
  tb_writed_enable=1;
  @(posedge tb_sramWrite);
  tb_writed_enable=0;
  #(WAIT/2);
  if(tb_sramAddr==32)
    $display("data write address correct");
  else
    $error("data write address incorrect");
    
  if(tb_sramWriteValue==tb_HWDATA)
    $display("data is writing correct value");
  else
    $error("data is writing incorrect value");
  
  
  tb_readd_enable=1;
  @(posedge tb_sramRead);
  tb_readd_enable=0;
  #(WAIT/2);
  if(tb_sramAddr==32)
    $display("data is looking in SRAM at correct address");
  else
    $error("data is looking in SRAM at incorrect address");
  
  #(CLKPERIOD);
  #(WAIT);
  
  if(tb_HRDATA==tb_HWDATA)
    $display("module outputs the correct value");
  else
    $error("moulde outputs incorrect value");
  
end
endmodule