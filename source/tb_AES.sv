`timescale 1ns / 100ps

module tb_AES();

localparam HCLKPERIOD=100;
localparam CLKPERIOD=10;
localparam WAIT=5;

reg tb_clk;
reg tb_n_rst;
reg tb_HCLK;
reg tb_HNRST;
reg [31:0]tb_HADDR;
reg [2:0]tb_HBURST;
reg tb_HMASTLOCK;
reg [3:0]tb_HPORT;
reg [2:0]tb_HSIZE;
reg [1:0]tb_HTRANS;
reg [127:0]tb_HWDATA;
reg tb_HWRITE;
reg tb_HSELx;
reg tb_HREADY;
reg tb_RESP;
reg [127:0]tb_HRDATA;
reg tb_HREADYOUT;
reg tb_sramBigDump;
reg [2:0]tb_sramBigDumpNum;

AES DUT
(
  .HCLK(tb_HCLK),
  .HNRST(tb_HNRST),
	.clk(tb_clk),
	.n_rst(tb_n_rst),
	.HADDR(tb_HADDR),
	.HBURST(tb_HBURST),
	.HMASTLOCK(tb_HMASTLOCK),
	.HPORT(tb_HPORT),
	.HSIZE(tb_HSIZE),
	.HTRANS(tb_HTRANS),
	.HWDATA(tb_HWDATA),
	.HWRITE(tb_HWRITE),
	.HSELx(tb_HSELx),
	.HREADY(tb_HREADY),
	.HRESP(tb_RESP),
	.HRDATA(tb_HRDATA),
	.HREADYOUT(tb_HREADYOUT),
	.sramBigDumpNum(tb_sramBigDumpNum),
	.sramBigDump(tb_sramBigDump)
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

initial
begin
  tb_sramBigDump=0;
  tb_sramBigDumpNum=0;
  tb_HNRST=1;
  tb_n_rst=0;
  tb_HADDR=0;
  tb_HBURST=3'b000;
  tb_HMASTLOCK=0;
  tb_HPORT=0;
  tb_HSIZE=3'b100;
  tb_HTRANS=2'b10;
  tb_HWRITE=1;
  tb_HSELx=0;
  tb_HREADY=0;
  #(WAIT*3);
  
  tb_n_rst=1;
  
  $display("Testing address/AMBA match response");
  tb_HADDR=32'hF0_F0_F0_F0;
  tb_HSIZE=3'b011;
  #(WAIT);
  tb_HSELx=1;
  
  @(negedge tb_HCLK);
  #(WAIT);
  if(tb_RESP==1)
    $display("design rejects AMBA HSIZE correctly");
  else
    $error("design rejects AMBA HSIZE incorrectly");
    
  tb_HSELx=0;
  @(posedge tb_HCLK);
  tb_HADDR=32'hF0_F0_F0_F0;
  tb_HSIZE=3'b100;
  tb_HBURST=3'b111;
  #(WAIT);
  tb_HSELx=1;
  
  @(negedge tb_HCLK);
  #(WAIT);
  if(tb_RESP==1)
    $display("design rejects AMBA HBURST correctly");
  else
    $error("design rejects AMBA HBURST incorrectly");
    
  tb_HSELx=0;
  @(posedge tb_HCLK);
  tb_HADDR=32'hF0_F0_F0_F0;
  tb_HSIZE=3'b100;
  tb_HBURST=3'b000;
  tb_HTRANS=2'b01;
  #(WAIT);
  
  tb_HSELx=1;
  @(negedge tb_HCLK);
  #(WAIT);
  if(tb_RESP==1)
    $display("design rejects AMBA HTRANS correctly");
  else
    $error("design rejects AMBA HTRANS incorrectly");
    
  
  tb_HSELx=0;
  @(posedge tb_HCLK);
  tb_HADDR=32'hF0_F0_F0_F0;
  tb_HSIZE=3'b100;
  tb_HBURST=3'b000;
  tb_HTRANS=2'b10;
  #(WAIT);
  
  tb_HSELx=1;
  @(posedge tb_HCLK);
  #(WAIT);
  if(tb_RESP==0)
    $display("design accepts AMBA everything correctly");
  else
    $error("design accepts AMBA everything incorrectly");
  
  
  tb_HWDATA=128'h2B_7E_15_16_28_AE_D2_A6_AB_F7_15_88_09_CF_4F_3C;
  #(WAIT);
  tb_HREADY=1;
  #(WAIT*2);
  tb_HREADY=0;
  
  
  @(negedge tb_HREADYOUT);
  tb_sramBigDump=1;
  #(WAIT);
  tb_sramBigDump=0;
  #(WAIT);
  #(WAIT/4);
  
  @(posedge tb_HCLK);
  tb_HADDR=32'hF0_F0_F0_F0;
  tb_HSIZE=3'b100;
  tb_HBURST=3'b000;
  tb_HTRANS=2'b10;
  #(WAIT);
  
  tb_HSELx=1;
  #(WAIT);
  tb_HSELx=0;
  
  tb_HWDATA=128'h32_43_F6_A8_88_5A_30_8D_31_31_98_A2_E0_37_07_34;
  #(WAIT);
  tb_HREADY=1;
  #(WAIT*2);
  tb_HREADY=0;
  
  @(negedge tb_HREADYOUT);
  tb_sramBigDump=1;
  #(WAIT);
  tb_sramBigDump=0;
  #(WAIT);
  
  
end

endmodule