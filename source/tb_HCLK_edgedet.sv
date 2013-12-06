`timescale 1ns / 100ps

module tb_HCLK_edgedet();

localparam CLKPERIOD=10;
localparam HCLKPERIOD=100;
localparam WAIT=5;

reg tb_clk;
reg tb_n_rst;
reg tb_HCLK;
reg tb_HCLK_rise;
reg tb_HCLK_fall;

HCLK_edgedet DUT
(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .HCLK(tb_HCLK),
  .HCLK_rise(tb_HCLK_rise),
  .HCLK_fall(tb_HCLK_fall)
);

always begin
  tb_clk=1;
  #(CLKPERIOD/2);
  tb_clk=0;
  #(CLKPERIOD/2);
end

always begin
  tb_HCLK=1;
  #(HCLKPERIOD/2);
  tb_HCLK=0;
  #(HCLKPERIOD/2);
end

initial begin
  tb_n_rst=0;
  #(WAIT*3);
  tb_n_rst=1;
end

endmodule