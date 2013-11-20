`timescale 1ns / 100ps

module tb_testing_sram();
  
localparam WAIT=5;

reg tb_read;
reg tb_write;
reg [15:0] tb_addr;
reg [7:0] tb_valueIn;
reg tb_dump;
reg tb_dumpNum;
reg [7:0] tb_valueOut;
reg [7:0] tb_expected;
reg [7:0] tb_test_num=0;

testing_sram DUT
(
  .read(tb_read),
  .write(tb_write),
  .addr(tb_addr),
  .valueIn(tb_valueIn),
  .dump(tb_dump),
  .dumpNum(tb_dumpNum),
  .valueOut(tb_valueOut)
);


initial begin
  tb_read=0;
  tb_write=0;
  #(WAIT);
  
  tb_addr=0;
  tb_valueIn=89;
  tb_write=1;
  
  #(WAIT);
  
  tb_write=0;
  tb_addr=59;
  tb_valueIn=210;
  tb_write=1;
  
  #(WAIT);
  
  tb_write=0;
  tb_addr=195;
  tb_valueIn=66;
  tb_write=1;
  
  #(WAIT);
  
  tb_write=0;
  tb_addr=0;
  tb_expected=89;
  tb_read=1;
  
  #(WAIT);
  
  tb_test_num=tb_test_num+1;
  if(tb_expected==tb_valueOut)
    $display("Test %d good", tb_test_num);
  else
    $error("Test %d bad", tb_test_num);
  
  tb_read=0;
  tb_addr=59;
  tb_expected=210;
  tb_read=1;
  
  #(WAIT);
  
  tb_test_num=tb_test_num+1;
  if(tb_expected==tb_valueOut)
    $display("Test %d good", tb_test_num);
  else
    $error("Test %d bad", tb_test_num);
    
  
  tb_read=0;
  tb_addr=195;
  tb_expected=66;
  tb_read=1;
  
  #(WAIT);
  
  tb_test_num=tb_test_num+1;
  if(tb_expected==tb_valueOut)
    $display("Test %d good", tb_test_num);
  else
    $error("Test %d bad", tb_test_num);
    
  tb_read=0;
  
  #(WAIT);
  tb_dumpNum=0;
  tb_dump=1;
    
end

endmodule