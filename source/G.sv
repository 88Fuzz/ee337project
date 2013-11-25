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
//                       0        1           2      3        4
typedef enum bit[3:0] {IDLE, LEFTROTATE, SBYTE2, SENABLE2, SBYTE1, 
//                                 5        6          7        8  
                                 BLANK1, SENABLE3, SENABLE4, SBYTE3,
                                 //9       10       11   12    13       14      15
                                 SBYTE4, PRERCON, RCON, DONE, BLANK2, SENABLE1, BLANK3} stateType;
stateType nextState, currState;
reg [31:0] tmp;
reg [7:0] tmpByteIn;
reg [7:0] tmpByteOut;
//reg sbytes_enable;
reg [31:0] outputValue;
reg [7:0] rconOut;

//tmp={inputVal[31:8], inputVal[7:0]};
assign outputVal=outputValue;


sbytes boop(
        .olddata(tmpByteIn),
//        .sbytes_enable(sbytes_enable),
        .newdata(tmpByteOut)
      );
      
rcon boopy(
        .roundNum(roundNum),
        .out(rconOut)
      );

always @(posedge clk, negedge n_rst) begin
  if(n_rst==0)
    currState<=IDLE;
  else
    currState<=nextState;
end

always @(currState, rconOut, tmpByteOut, tmp, inputVal) begin//fill out this stuff
  case(currState)
    IDLE:begin
      done=0;
//      sbytes_enable=0;
    end
    LEFTROTATE: begin
      done=0;
//      tmp={inputVal[31:8], inputVal[7:0]};
      tmp<={inputVal[23:0],inputVal[31:24]};
    //  sbytes_enable=0;
    end
    SENABLE1: begin
      tmpByteIn<=tmp[7:0];
      done=0;
    //  sbytes_enable=1;
    end
    SBYTE1: begin
      tmp[7:0]<=tmpByteOut;
      done=0;
//      sbytes_enable=1;
   //   sbytes_enable=0;
    end
    SENABLE2: begin
      tmpByteIn<=tmp[15:8];//doing some weird foot work to see if this will work
      done=0;
    //  sbytes_enable=1;
    end
    SBYTE2: begin
      tmp[15:8]<=tmpByteOut;
      done=0;
   //   sbytes_enable=0;
      
    end
    SENABLE3: begin
      tmpByteIn<=tmp[23:16];
      done=0;
   //   sbytes_enable=1;
    end
    SBYTE3: begin
      tmp[23:16]<=tmpByteOut;
      done=0;
   //   sbytes_enable=0;
    end
    SENABLE4: begin
      tmpByteIn<=tmp[31:24];
      done=0;
   //   sbytes_enable=1;
    end
    SBYTE4: begin
      tmp[31:24]<=tmpByteOut;
      done=0;
   //   sbytes_enable=0;
    end
    PRERCON: begin
      done=0;
   //   sbytes_enable=0;
    end
    RCON: begin
      done=0;
   //   sbytes_enable=0;
      outputValue<=tmp^{rconOut,24'h0};
    end
    DONE: begin
      done=1;
   //   sbytes_enable=0;
    end
    BLANK1: begin
      done=0;
    end
    BLANK2: begin
      done=0;
    end
    BLANK3: begin
      done=0;
    end
    default: begin
      done=0;
    //  sbytes_enable=0;
    end
  endcase
end

always @(currState, enable) begin
  case(currState)
    IDLE:begin
      if(enable)
        nextState<=LEFTROTATE;
    end
    LEFTROTATE: begin
      nextState<=SENABLE1;
    end
    SENABLE1: begin
      nextState<=SBYTE1;
    end
    SBYTE1: begin
      nextState<=SENABLE2;
    end
    SENABLE2: begin
      nextState<=SBYTE2;
    end
    SBYTE2: begin
      nextState<=SENABLE3;
    end
    SENABLE3: begin
      nextState<=SBYTE3;
    end
    SBYTE3: begin
      nextState<=SENABLE4;
    end
    SENABLE4: begin
      nextState<=SBYTE4;
    end
    SBYTE4: begin
      nextState<=PRERCON;
    end
    PRERCON: begin
      nextState<=RCON;
    end
    RCON: begin
      nextState<=DONE;
    end
    DONE: begin
      nextState<=IDLE;
    end
    default: begin
    end
  endcase
end

endmodule
