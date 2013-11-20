module G
(
  input clk,
  input n_rst,
  input wire enable,
  input wire [31:0] inputVal,
  input wire [3:0] roundNum,
  output wire [31:0] outputVal,
  output reg done
);

typedef enum bit[3:0] {IDLE, LEFTROTATE, SBYTE1, SBYTE2, SBYTE3, SBYTE4, RCON, DONE} stateType;
stateType nextState, currState;
reg [31:0] tmp;
reg [7:0] tmpByteIn;
reg [7:0] tmpByteOut;
reg sbytes_enable;

//tmp={inputVal[31:8], inputVal[7:0]};



sbytes boop(
        .olddata(tmpByteIn),
        .sbytes_enable(sbytes_enable),
        .newdata(tmpByteOut)
      );

always @(posedge clk, negedge n_rst) begin
  if(n_rst==0)
    currState<=IDLE;
  else
    currState<=nextState;
end

always @(currState) begin//fill out this stuff
  case(currState)
    IDLE:begin
      done=0;
    end
    LEFTROTATE: begin
      done=0;
      tmp={inputVal[31:8], inputVal[7:0]};
    end
    SBYTE1: begin
      done=0;
    end
    SBYTE2: begin
      done=0;
    end
    SBYTE3: begin
      done=0;
    end
    SBYTE4: begin
      done=0;
    end
    RCON: begin
      done=0;
    end
    DONE: begin
      done=1;
    end
    default: begin
      done=0;
    end
  endcase
end

always @(currState, enable) begin
  case(currState)
    IDLE:begin
      if(enable)
        nextState=LEFTROTATE;
    end
    LEFTROTATE: begin
      nextState=SBYTE1;
    end
    SBYTE1: begin
      nextState=SBYTES2;
    end
    SBYTE2: begin
      nextState=SBYTES3;
    end
    SBYTE3: begin
      nextState=SBYTES4;
    end
    SBYTE4: begin
      nextState=RCON;
    end
    RCON: begin
      nextState=DONE;
    end
    DONE: begin
      nextState=IDLE;
    end
    default: begin
    end
  endcase
end

endmodule