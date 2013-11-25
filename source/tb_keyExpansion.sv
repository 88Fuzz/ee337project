`timescale 1ns / 100ps

module tb_keyExpansion();

localparam CLKPERIOD=10;
localparam WAIT=5;

reg tb_clk;
reg tb_n_rst;
reg [3:0] tb_roundNum;
reg tb_enable;
reg tb_expansionDone;

keyExpansion DUT(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .roundNum(tb_roundNum),
  .enable(tb_enable),
  .expansionDone(tb_expansionDone)
  );


always begin
  tb_clk=1;
  #(CLKPERIOD/2);
  tb_clk=0;
  #(CLKPERIOD/2);
end

initial begin
  tb_n_rst=0;
  #(WAIT);
  tb_n_rst=1;
  #(WAIT);
  
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