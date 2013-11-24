`timescale 1ns / 100ps

module tb_sbytes();

localparam WAIT=6;

reg [7:0] tb_olddata;
reg [7:0] tb_newdata;
reg [7:0] tb_expected;
reg [7:0] tb_test_num=0;
//reg tb_sbytes_enable;

sbytes setybs
(
  .olddata(tb_olddata),
//  .sbytes_enable(tb_sbytes_enable),
  .newdata(tb_newdata)
);

initial
begin
  
//  tb_sbytes_enable=0;
//  #(WAIT*2);
//  tb_sbytes_enable=1;
//  #(WAIT*2);
  
  
//  tb_sbytes_enable=0;
//  #(WAIT*2);
  tb_olddata=67;
  #(WAIT);
//  tb_sbytes_enable=1;
//  #(WAIT);
  
  tb_expected=26;
  tb_test_num=tb_test_num+1;
  if(tb_newdata==tb_expected)
    $display("Test %d good", tb_test_num);
  else
    $error("Test %d bad", tb_test_num);
    

  
  
 // tb_sbytes_enable=0;
 // #(WAIT*2);
  tb_olddata=0;
  #(WAIT);
 // tb_sbytes_enable=1;
 // #(WAIT);
  
  tb_expected=99;
  tb_test_num=tb_test_num+1;
  if(tb_newdata==tb_expected)
    $display("Test %d good", tb_test_num);
  else
    $error("Test %d bad", tb_test_num);
    

    
 // tb_sbytes_enable=0;
 // #(WAIT*2);
  tb_olddata=255;
  #(WAIT);
 // tb_sbytes_enable=1;
 // #(WAIT);
  
  tb_expected=22;
  tb_test_num=tb_test_num+1;
  if(tb_newdata==tb_expected)
    $display("Test %d good", tb_test_num);
  else
    $error("Test %d bad", tb_test_num);
    
    

    
 // tb_sbytes_enable=0;
 // #(WAIT*2);
  tb_olddata=116;
  #(WAIT);
 // tb_sbytes_enable=1;
 // #(WAIT);
  
  tb_expected=146;
  tb_test_num=tb_test_num+1;
  if(tb_newdata==tb_expected)
    $display("Test %d good", tb_test_num);
  else
    $error("Test %d bad", tb_test_num);
  
  

  
 // tb_sbytes_enable=0;
 // #(WAIT*2);
  tb_olddata=97;
  #(WAIT);
 // tb_sbytes_enable=1;
 // #(WAIT);
  
  tb_expected=239;
  tb_test_num=tb_test_num+1;
  if(tb_newdata==tb_expected)
    $display("Test %d good", tb_test_num);
  else
    $error("Test %d bad", tb_test_num);
  
  
end

endmodule