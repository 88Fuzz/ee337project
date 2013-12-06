module HCLK_edgedet
(
  input wire clk,
  input wire n_rst,
  input wire HCLK,
  output wire HCLK_rise,
  output wire HCLK_fall
);

reg past;
reg curr;
reg future;


assign HCLK_rise=(~past) & curr;//curr & (curr & ~past);
assign HCLK_fall=past & (~curr);//~curr & (curr & ~past);

always @(posedge clk, negedge n_rst) begin
  if(n_rst==0) begin
    past<=1;
    curr<=1;
    future<=1;
  end else begin
    past<=curr;
    curr<=future;
    future<=HCLK;
  end
end

endmodule
  