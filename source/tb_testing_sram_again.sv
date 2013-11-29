`timescale 1ns / 100ps

module tb_testing_sram_again();
  
localparam WAIT=5;

reg tb_read;
reg tb_write;
reg [15:0] tb_addr;
reg [127:0] tb_valueIn;
reg tb_dump;
reg [2:0] tb_dumpNum;
reg tb_in;
reg [2:0] tb_inNum;
reg [127:0] tb_valueOut;
reg [127:0] tb_expected;
reg [7:0] tb_test_num=0;



reg tb_read2;
reg tb_write2;
reg [15:0] tb_addr2;
reg [127:0] tb_valueIn2;
reg tb_dump2;
reg [2:0]tb_dumpNum2;
reg tb_in2;
reg [2:0]tb_inNum2;
reg [127:0] tb_valueOut2;
reg [127:0] tb_expected2;
reg [7:0] tb_test_num2=0;

testing_sram DUT
(
  .read(tb_read),
  .write(tb_write),
  .addr(tb_addr),
  .write_data(tb_valueIn),
  .dump(tb_dump),
  .dumpNum(tb_dumpNum),
  .init(tb_in),
  .initNum(tb_inNum),
  .read_data(tb_valueOut)
);

testing_sram_again DUT2
(
  .read(tb_read2),
  .write(tb_write2),
  .addr(tb_addr2),
  .write_data(tb_valueIn2),
  .dump(tb_dump2),
  .dumpNum(tb_dumpNum2),
  .init(tb_in2),
  .initNum(tb_inNum2),
  .read_data(tb_valueOut2)
);


initial begin
  
  tb_read=0;
  tb_write=0;
  tb_addr=0;
  tb_valueIn=128'h09_CF_4F_3C__AB_F7_15_88__28_AE_D2_A6__2B_7E_15_16;
  #(WAIT);
  tb_write=1;
  #(WAIT);
  tb_write=0;
  tb_dumpNum=1;
  tb_dump=1;
  #(WAIT);
  tb_dump=0;
  #(WAIT);
  tb_read=1;
  #(WAIT);
  tb_read=0;
  /*
  //writing to sram
  tb_read=0;
  tb_write=0;
  #(WAIT);
  
  tb_addr=0;
  tb_valueIn=128'h01_23_45_67_89_AB_CD_EF_FE_DC_BA_98_76_54_32_10;
  tb_write=1;
  
  #(WAIT);
  
  tb_write=0;
  tb_addr=16;
  tb_valueIn=128'hFF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF;
  tb_write=1;
  
  #(WAIT);
  
  tb_write=0;
  tb_addr=32;
  tb_valueIn=128'hAA_BB_CC_DD_EE_FF_00_99_88_77_66_55_44_33_22_11;
  tb_write=1;
  
  #(WAIT);
  tb_write=0;
  
  
  //dumping sram
  #(WAIT);
  tb_dumpNum=0;
  tb_dump=1;
  
  #(WAIT);
  tb_dump=0;
  
  
  //loading sram from file
  tb_read2=0;
  tb_write2=0;
  tb_inNum2=0;
  tb_in2=1;
  #(WAIT);
  tb_in2=0;
  #(WAIT);
  
  
  //reading from sram
  tb_write2=0;
  tb_addr2=0;
  tb_expected2=128'h01_23_45_67_89_AB_CD_EF_FE_DC_BA_98_76_54_32_10;
  tb_read2=1;
  
  #(WAIT*2);
  
  tb_test_num2=tb_test_num2+1;
  if(tb_expected2==tb_valueOut2)
    $display("Test %d good", tb_test_num2);
  else
    $error("Test %d bad", tb_test_num2);
  
  tb_read2=0;
  tb_addr2=16;
  tb_expected2=128'hFF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF_FF;
  tb_read2=1;
  
  #(WAIT*2);
  
  tb_test_num2=tb_test_num2+1;
  if(tb_expected2==tb_valueOut2)
    $display("Test %d good", tb_test_num2);
  else
    $error("Test %d bad", tb_test_num2);
    
  
  tb_read2=0;
  tb_addr2=32;
  tb_expected2=128'hAA_BB_CC_DD_EE_FF_00_99_88_77_66_55_44_33_22_11;
  tb_read2=1;
  
  #(WAIT*2);
  
  tb_test_num2=tb_test_num2+1;
  if(tb_expected2==tb_valueOut2)
    $display("Test %d good", tb_test_num2);
  else
    $error("Test %d bad", tb_test_num2);
    
  tb_read2=0;
  
  
  //dumping sram
  #(WAIT);
  tb_dumpNum2=1;
  tb_dump2=1;
  
  #(WAIT);*/
    
end

endmodule
