module G
(
  input clk,
  input n_rst,
  input wire enable,
  input wire [31:0] inputVal,
  input wire [3:0] roundNum,
  output wire [31:0] finalOutputVal,
  output reg done
);
//                       0        1           2      3        4
typedef enum bit[3:0] {IDLE, LEFTROTATE, SBYTE2, SENABLE2, SBYTE1, 
//                                 5        6          7        8  
                                 BLANK1, SENABLE3, SENABLE4, SBYTE3,
                                 //9       10       11   12    13       14      15
                                 SBYTE4, PRERCON, RCON, DONE, BLANK2, SENABLE1, BLANK3} stateType;
stateType nextState, currState;
reg [31:0] nextTmp;
reg [31:0] currTmp;
reg [7:0] tmpByteIn;
reg [7:0] tmpByteOut;
//reg sbytes_enable;
reg [31:0] currOutputValue;
reg [31:0] nextOutputValue;
reg [7:0] rconOut;
//reg [7:0] currRconOut;//will this work??
//reg tmpRconOut=currRconOut;

//tmp={inputVal[31:8], inputVal[7:0]};
assign finalOutputVal=currOutputValue;


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
  if(n_rst==0) begin
    currState<=IDLE;
    currTmp<=0;
    currOutputValue<=0;
  end else begin
    currState<=nextState;
    currTmp<=nextTmp;
    currOutputValue<=nextOutputValue;
  end
end

always @(currState) begin//fill out this stuff
  case(currState)
    IDLE:begin
      done=0;
//      sbytes_enable=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
    end
    LEFTROTATE: begin
      done=0;
//      tmp={inputVal[31:8], inputVal[7:0]};
      nextTmp={inputVal[23:0],inputVal[31:24]};
      nextOutputValue=currOutputValue;
    //  sbytes_enable=0;
    end
    SENABLE1: begin
      tmpByteIn=currTmp[7:0];
      done=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
    //  sbytes_enable=1;
    end
    SBYTE1: begin
      nextTmp={currTmp[31:8],tmpByteOut};
      done=0;
      nextOutputValue=currOutputValue;
//      sbytes_enable=1;
   //   sbytes_enable=0;
    end
    SENABLE2: begin
      tmpByteIn=currTmp[15:8];//doing some weird foot work to see if this will work
      done=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
    //  sbytes_enable=1;
    end
    SBYTE2: begin
      nextTmp={currTmp[31:16],tmpByteOut,currTmp[7:0]};//{currTmp[7:0],tmpByteOut,currTmp[31:16]};
      done=0;
      nextOutputValue=currOutputValue;
   //   sbytes_enable=0;
    end
    SENABLE3: begin
      tmpByteIn=currTmp[23:16];
      done=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
   //   sbytes_enable=1;
    end
    SBYTE3: begin
      nextTmp={currTmp[31:24],tmpByteOut,currTmp[15:0]};//{currTmp[15:0],tmpByteOut,currTmp[31:24]};
      done=0;
      nextOutputValue=currOutputValue;
   //   sbytes_enable=0;
    end
    SENABLE4: begin
      tmpByteIn=currTmp[31:24];
      done=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
   //   sbytes_enable=1;
    end
    SBYTE4: begin
      nextTmp={tmpByteOut,currTmp[23:0]};//{currTmp[23:0],tmpByteOut};
      done=0;
      nextOutputValue=currOutputValue;
   //   sbytes_enable=0;
    end
    PRERCON: begin
      done=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
   //   sbytes_enable=0;
    end
    RCON: begin
      done=0;
      nextTmp=currTmp;
   //   sbytes_enable=0;
      nextOutputValue=currTmp^{rconOut,24'h0};
    end
    DONE: begin
      done=1;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
   //   sbytes_enable=0;
    end
    BLANK1: begin
      done=0;
//      sbytes_enable=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
    end
    BLANK2: begin
      done=0;
//      sbytes_enable=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
    end
    BLANK3: begin
      done=0;
//      sbytes_enable=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
    end
    default: begin
      done=0;
//      sbytes_enable=0;
      nextTmp=currTmp;
      nextOutputValue=currOutputValue;
    //  sbytes_enable=0;
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
      nextState=SENABLE1;
    end
    SENABLE1: begin
      nextState=SBYTE1;
    end
    SBYTE1: begin
      nextState=SENABLE2;
    end
    SENABLE2: begin
      nextState=SBYTE2;
    end
    SBYTE2: begin
      nextState=SENABLE3;
    end
    SENABLE3: begin
      nextState=SBYTE3;
    end
    SBYTE3: begin
      nextState=SENABLE4;
    end
    SENABLE4: begin
      nextState=SBYTE4;
    end
    SBYTE4: begin
      nextState=PRERCON;
    end
    PRERCON: begin
      nextState=RCON;
    end
    RCON: begin
      nextState=DONE;
    end
    DONE: begin
      nextState=IDLE;
    end
    default: begin
      nextState=IDLE;
    end
  endcase
end

endmodule
