`timescale 1ns / 100ps
module tb_G();

localparam CLKPERIOD=10;  
localparam WAIT=CLKPERIOD/4;

reg tb_clk;
reg tb_n_rst;
reg tb_enable;
reg [31:0] tb_inputVal;
reg [3:0] tb_roundNum;
reg [31:0] tb_outputVal;
reg tb_done;
reg [31:0] tb_expected_out;



G DUT(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .enable(tb_enable),
  .inputVal(tb_inputVal),
  .roundNum(tb_roundNum),
  .outputVal(tb_outputVal),
  .done(tb_done)
);

always begin
  tb_clk=1;
  #(CLKPERIOD/2);
  tb_clk=0;
  #(CLKPERIOD/2);
end

initial
begin
  tb_enable=0;
  tb_n_rst=0;
  #(CLKPERIOD);
  tb_n_rst=1;
  #(CLKPERIOD);
  
  @(negedge tb_clk);
  tb_inputVal=32'hAA_AA_AA_AA;
  tb_roundNum=1;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  tb_expected_out=32'hAD_AC_AC_AC;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
    
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'hF0_45_FF_8B;
  tb_roundNum=2;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
    
  
  
  
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'hFF_FF_FF_FF;
  tb_roundNum=3;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
  
  
  
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'h00_00_00_00;
  tb_roundNum=4;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
  
  
  
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'h12_34_56_78;
  tb_roundNum=5;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'h87_65_43_21;
  tb_roundNum=6;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
  
  
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'hA5_F3_DF_8B;
  tb_roundNum=7;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
  
  
  
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'h66_E5_F9_B9;
  tb_roundNum=8;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
  
  
  
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'h00_C6_F2_67;
  tb_roundNum=9;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
  
  
  
  
  @(negedge tb_clk);
  @(negedge tb_clk);
  tb_inputVal=32'hF1_CD_6F_EE;
  tb_roundNum=10;
  tb_enable=1;
  
  @(posedge tb_clk);
  #(WAIT);
  tb_enable=0;
  //tb_expected_out=32'h;
  @(posedge tb_done);
  if(tb_expected_out==tb_outputVal)
    $display("round %d is good", tb_roundNum);
  else
    $error("round %d is bad", tb_roundNum);
  
  
    
    
    
    
    
  
  
end

endmodule