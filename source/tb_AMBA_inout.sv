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

module AMBA_inout
(
  .clk(tb_clk),
  .n_rst(tb_n_rst),
  .writek_enable(tb_writek_enable),//master writing key
  .writed_enable(tb_writed_enable),//master writing data
  .readd_enable(tb_readd_enable),//master reading data
  .hresp_error(tb_hresp_error),
  .hready_enable(tb_hready_enable),
  .read_data(tb_sramReadValue),
  .write_data(tb_sramWriteValue),
  .HWDATA(tb_HWDATA),
  //output
  .HRDATA(tb_HRDATA),
  .HREADYOUT(tb_HREADYOUT),
  .HRESP(tb_HRESP)
);
  output reg [127:0] write_data,
  output reg HREADYOUT,
  output reg HRESP,
  output reg read,
  output reg write,
  output reg [15:0] addr,
  output reg dump,
  output reg [2:0] dumpNum,
  output reg [2:0] initNum,
  output reg init
testing_sram ssssRAM
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
end