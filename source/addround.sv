module addround
(
	//input wire clk,
	input wire n_rst,
	input wire around_enable,
	input wire [7:0] subkey,
	input wire [7:0] olddata,
	output reg [7:0] newdata
);

  assign newdata = (n_rst) ? ((around_enable) ? (subkey ^ olddata) : olddata) : olddata;
  
  /*always@(posedge clk, negedge n_rst) begin
    if(n_rst == 1'b0) begin
      newdata <= '0;
    end else begin
      newdata <= subkey ^ olddata;
    end
  end*/
endmodule
