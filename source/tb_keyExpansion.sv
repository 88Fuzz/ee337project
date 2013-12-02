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
reg [127:0]tb_expected;


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
  tb_enable=0;
  tb_realInitNum=1;
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
  
  tb_roundNum=0+1;
  tb_enable=1;
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h09_CF_4F_3C__AB_F7_15_88__28_AE_D2_A6__2B_7E_15_16;//128'h0F_0E_0D_0C_0B_0A_09_08_07_06_05_04_03_02_01_00;//128'h00_01_02_03_04_05_06_07_08_09_0A_0B_0C_0D_0E_0F;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
    
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  #(WAIT);
  tb_roundNum=1+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h2A_6C_76_05__23_A3_39_39__88_54_2C_B1__A0_FA_FE_17;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  

  
  #(WAIT);
  tb_roundNum=2+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h73_59_F6_7F__59_35_80_7A__7A_96_B9_43__F2_C2_95_F2;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  
  #(WAIT);
  tb_roundNum=3+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h6D_7A_88_3B__1E_23_7E_44__47_16_FE_3E__3D_80_47_7D;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  
  #(WAIT);
  tb_roundNum=4+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'hDB_0B_AD_00__B6_71_25_3B__A8_52_5B_7F__EF_44_A5_41;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  
  #(WAIT);
  tb_roundNum=5+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h11_F9_15_BC__CA_F2_B8_BC__7C_83_9D_87__D4_D1_C6_F8;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  
  #(WAIT);
  tb_roundNum=6+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'hCA_00_93_FD__DB_F9_86_41__11_0B_3E_FD__6D_88_A3_7A;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  

  #(WAIT);
  tb_roundNum=7+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h4E_A6_DC_4F__84_A6_4F_B2__5F_5F_C9_F3__4E_54_F7_0E;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  
  #(WAIT);
  tb_roundNum=8+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h7F_8D_29_2F__31_2B_F5_60__B5_8D_BA_D2__EA_D2_73_21;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  
  #(WAIT);
  tb_roundNum=9+1;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'h57_5C_00_6E__28_D1_29_41__19_FA_DC_21__AC_77_66_F3;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum-1);
  else
    $error("round %d no works!", tb_roundNum-1);
  
  @(posedge tb_expansionDone);
  tb_enable=0;
  
  
  #(WAIT);
  tb_roundNum=10-10;
  #(WAIT*1.5);
  tb_enable=1;
  
  
  @(posedge tb_sramWrite);//110ns
  tb_expected=128'hB6_63_0C_A6__E1_3F_0C_C8__C9_EE_25_89__D0_14_F9_A8;
  #(WAIT/2);
  if(tb_expected==tb_sramWriteValue)
    $display("round %d works!", tb_roundNum+10);
  else
    $error("round %d no works!", tb_roundNum+10);
  
  @(posedge tb_expansionDone);
  tb_enable=0;


  
end
endmodule