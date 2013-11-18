module keyExpansion
(
  input wire clk,
  input wire n_rst,
  input wire [127:0] pastKey,
  input wire [3:0] roundNum,
  input wire enable,
  output reg [127:0] newKey
);

reg [15:0] gReturn;

typedef enum bit[4:0] {IDLE, CHECKROUND, G, XOR1, XOR2, XOR3, XOR4, DONE} stateType;//will need states for loading and unloading SRAM
stateType currState, nextState;

always @(posedge clk, negedge n_rst) begin
  if(n_rst==0) begin
    currState<=IDLE;
  else
    currState<=nextState;
end

always@(currState)begin
  case(currState)
    IDLE: begin
    end
    CHECKROUND: begin
    end
    G: begin
    end
    XOR1: begin
    end
    XOR2: begin
    end
    XOR3: begin
    end
    XOR4: begin
    end
    DONE: begin
    end
    default: begin//same as IDLE
    end
  endcase
end

always @ (currState, enable, pastKey, roundNum) begin
  case(currState)
    IDLE: begin
      if(enable)
        nextState=CHECKROUND;//maybe a load state
    end
    CHECKROUND: begin
    end
    G: begin
    end
    XOR1: begin
    end
    XOR2: begin
    end
    XOR3: begin
    end
    XOR4: begin
    end
    DONE: begin
    end
    default: begin//same as IDLE
    end
  endcase
end
