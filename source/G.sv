module G
(
  input wire [31:0] inputVal,
  input wire [3:0] roundNum,
  output wire [31:0] outputVal
);
reg [31:0] tmp;

tmp={inputVal[31:8], inputVal[7:0]};


endmodule