module AMBAsensor
(
  input wire clk,
  input wire n_rst,
  input wire [31:0] HADDR,
  input wire [2,0] HBURST,
  input wire HMASTLOCK,
  input wire [3,0] HPORT,
  input wire [2,0] HSIZE,
  input wire [1,0] HTRANS,
  input wire HWRITE,//high=write, low=read
  input wire HSELx,
  input wire HREADY,
  output reg addrMatch,
  output reg mWrite,
  output reg mRead,
  output reg dataReady,
  output reg invalid
);

localparam addr=32'hF0F0F0F0;

assign addrMatch = (addr==HADDR) ? 1'b1 : 1'b0;
assign mWrite=HWRITE;
assign mRead=~HWRITE;

