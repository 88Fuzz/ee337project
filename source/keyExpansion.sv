module keyExpansion
(
  input wire clk,
  input wire n_rst,
  input wire [3:0] roundNum,
  input wire enable,
  input wire [127:0]sramReadValue,
  output reg expansionDone,
  output reg [127:0]sramWriteValue,
  output reg sramRead,
  output reg sramWrite,
  output reg sramDump,
  output reg sramInit,
  output reg [15:0]sramAddr,
  output reg [2:0] sramDumpNum,
  output reg [2:0] sramInitNum
);

reg [31:0] gReturn;
reg [31:0] gEnter;
reg [127:0] currNewKey;
reg [127:0] nextNewKey;
//reg [127:0] newKey;
//reg [127:0] oldKey;
//reg tmp;
//reg read;
//reg write;
//reg dump;
//reg init;
//reg [15:0] addr;
reg g_enable;
reg g_done;
//reg [2:0] dumpNum;
//reg [2:0] inNum;

G gggg(
       .clk(clk),
       .n_rst(n_rst),
       .enable(g_enable),
       .inputVal(gEnter),
       .roundNum(roundNum),
       .finalOutputVal(gReturn),
       .done(g_done)
       );

/*testing_sram tttttttt(
              .read(read),
              .write(write),
              .addr(addr),
              .write_data(newKey),
              .dump(dump),
              .dumpNum(dumpNum),
              .in(init),
              .inNum(inNum),
              .read_data(oldKey)
              );*/
                      //0        1              2           3                  4    5    6   7       8     9
typedef enum bit[4:0] {IDLE, READSRAM1, READSRAMELSEADDR, READSRAMELSE, CHECKROUND, G, XOR1, XOR2, XOR3, XOR4,
  //                      10    11         12     13           14           15     16     17     18
                         DONE, PREPG, WRITESRAM, PREPSRAM, READSRAM1AGAIN, BUFF1, BUFF2, BUFF3, BUFF4} stateType;//will need states for loading and unloading SRAM
stateType currState, nextState;


always @(posedge clk, negedge n_rst) begin
  if(n_rst==0) begin
    currState<=IDLE;
    currNewKey<=0;
  end
  else begin
    currState<=nextState;
    currNewKey<=nextNewKey;
  end
end

always@(currState, currNewKey, sramReadValue, gReturn)begin
  case(currState)
    IDLE: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    /*INITSRAM: begin
      tmp=0;
      read=0;
      write=0;
      dump=0;
      init=1;
      expansionDone=0;
      addr=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end*/
    READSRAM1: begin
      sramWriteValue=0;
      sramRead=1;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    READSRAM1AGAIN: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      g_enable=0;
      nextNewKey=sramReadValue;
      gEnter=0;
    end
    READSRAMELSEADDR: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=16;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    READSRAMELSE: begin
      sramWriteValue=0;
      sramRead=1;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=16;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    PREPG: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      //gEnter=sramReadValue[127:96];//THIS MAY BE BACKWARDS                                         MOVE THIS PLACES
      gEnter=sramReadValue[31:0];
      g_enable=0;
      nextNewKey=currNewKey;
    end
    CHECKROUND: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      //gEnter=sramReadValue[127:96];//THIS MAY BE BACKWARDS                                         MOVE THIS PLACES
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    G: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      g_enable=1;
      nextNewKey=currNewKey;
      gEnter=sramReadValue[31:0];//gEnter=sramReadValue[127:96];
    end
    XOR1: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
//      newKey[31:0]=oldKey[31:0]^gReturn;
      //nextNewKey={sramReadValue[127:32],sramReadValue[31:0]^gReturn};//////////////////////////////////
      nextNewKey={sramReadValue[127:96]^gReturn,sramReadValue[95:0]};
      g_enable=0;
      gEnter=0;
    end
    XOR2: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      //newKey[63:32]=oldKey[63:32]^newKey[31:0];
      //nextNewKey={sramReadValue[127:64],sramReadValue[63:32]^currNewKey[31:0],currNewKey[31:0]};
      nextNewKey={currNewKey[127:96],currNewKey[127:96]^sramReadValue[95:64],sramReadValue[63:0]};
      g_enable=0;
      gEnter=0;
    end
    XOR3: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
//      newKey[95:64]=oldKey[95:64]^newKey[63:32];
      //nextNewKey={sramReadValue[127:96],sramReadValue[95:64]^currNewKey[63:32],currNewKey[63:0]};
      nextNewKey={currNewKey[127:64],currNewKey[95:64]^sramReadValue[63:32], sramReadValue[31:0]};
      g_enable=0;
      gEnter=0;
    end
    XOR4: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      //newKey[127:96]=oldKey[127:96]^newKey[95:64];
      //nextNewKey={sramReadValue[127:96]^currNewKey[95:64],currNewKey[95:0]};
      nextNewKey={currNewKey[127:32], currNewKey[63:32]^sramReadValue[31:0]};
      g_enable=0;
      gEnter=0;
    end
    PREPSRAM: begin
      sramWriteValue=currNewKey;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=16;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      //newKey=oldKey;
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    WRITESRAM: begin
      sramWriteValue=currNewKey;
      sramRead=0;
      sramWrite=1;
      sramDump=0;
      sramInit=0;
      sramAddr=16;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    /*DUMPSRAM: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=16;
      dump=1;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end*/
    DONE: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=1;//probably need a new state for this after everything has been stored in sram
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    BUFF1: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;//probably need a new state for this after everything has been stored in sram
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    BUFF2: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;//probably need a new state for this after everything has been stored in sram
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    BUFF3: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;//probably need a new state for this after everything has been stored in sram
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    BUFF4: begin
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;//probably need a new state for this after everything has been stored in sram
      g_enable=0;
      nextNewKey=currNewKey;
      gEnter=0;
    end
    default: begin//same as IDLE
      sramWriteValue=0;
      sramRead=0;
      sramWrite=0;
      sramDump=0;
      sramInit=0;
      sramAddr=0;
      sramDumpNum=0;
      sramInitNum=0;
      expansionDone=0;
      g_enable=0;
      nextNewKey=0;
      gEnter=0;
    end
  endcase
end

always @ (currState, enable, roundNum, g_done) begin
  case(currState)
    IDLE: begin
      nextState=IDLE;
      if(enable) begin
        nextState=CHECKROUND;//maybe a load state
      end
    end
/*    INITSRAM: begin
      nextState=CHECKROUND;
    end*/
    READSRAM1: begin
      nextState=READSRAM1AGAIN;
    end
    READSRAM1AGAIN: begin
      nextState=PREPSRAM;
    end
    READSRAMELSEADDR: begin
      nextState=READSRAMELSE;
    end
    PREPG: begin
      nextState=G;
    end
    READSRAMELSE: begin
      nextState=PREPG;
    end
    CHECKROUND: begin
      if(roundNum==1) begin
        nextState=READSRAM1;
      end else begin
        nextState=READSRAMELSEADDR;
      end
    end
    G: begin
      nextState=G;
      if(g_done)
        nextState=XOR1;
    end
    XOR1: begin
      nextState=XOR2;//may need more than one clock cycle?????
    end
    XOR2: begin
      nextState=XOR3;//may need more than one clock cycle?????
    end
    XOR3: begin
      nextState=XOR4;//may need more than one clock cycle?????
    end
    XOR4: begin
      nextState=PREPSRAM;//may need more than one clock cycle?????
    end
    PREPSRAM: begin
      nextState=WRITESRAM;
    end
    WRITESRAM: begin
      nextState=DONE;
    end
    /*DUMPSRAM: begin
      nextState=DONE;
    end*/
    DONE: begin
      nextState=BUFF1;
    end
    BUFF1: begin
      nextState=BUFF2;
    end
    BUFF2: begin
      nextState=BUFF3;
    end
    BUFF3: begin
      nextState=BUFF4;
    end
    BUFF4: begin
      nextState=IDLE;
    end
    default: begin
      nextState=IDLE;
    end
  endcase
end

endmodule