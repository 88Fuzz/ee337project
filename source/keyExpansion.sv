module keyExpansion
(
  input wire clk,
  input wire n_rst,
  input wire [3:0] roundNum,
  input wire enable,
  output reg expansionDone
);

reg [31:0] gReturn;
reg [31:0] gEnter;
reg [127:0] newKey;
reg [127:0] oldKey;
reg tmp;
reg read;
reg write;
reg dump;
reg init;
reg [15:0] addr;
reg g_enable;
reg g_done;
reg [2:0] dumpNum;
reg [2:0] inNum;

G gggg(
       .clk(clk),
       .n_rst(n_rst),
       .enable(g_enable),
       .inputVal(gEnter),
       .roundNum(roundNum),
       .outputVal(gReturn),
       .done(g_done)
       );

testing_sram tttttttt(
              .read(read),
              .write(write),
              .addr(addr),
              .write_data(newKey),
              .dump(dump),
              .dumpNum(dumpNum),
              .in(init),
              .inNum(inNum),
              .read_data(oldKey)
              );

typedef enum bit[4:0] {IDLE, INITSRAM, DUMPSRAM, READSRAM1, READSRAMELSE, CHECKROUND, G, XOR1, XOR2, XOR3, XOR4,
                         DONE, READSRAM, WRITESRAM, PREPSRAM} stateType;//will need states for loading and unloading SRAM
stateType currState, nextState;

always @(posedge clk, negedge n_rst) begin
  if(n_rst==0) begin
    currState<=IDLE;
  end
  else begin
    currState<=nextState;
  end
end

always@(currState)begin
  case(currState)
    IDLE: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=0;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    INITSRAM: begin
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
    end
    READSRAM1: begin
      tmp=0;
      read=1;
      write=0;
      expansionDone=0;
      addr=0;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    READSRAMELSE: begin
      tmp=0;
      read=1;
      write=0;
      expansionDone=0;
      addr=16;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    CHECKROUND: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=0;
      dump=0;
      init=0;
      gEnter=oldKey[127:96];//THIS MAY BE BACKWARDS
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    G: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=16;
      dump=0;
      init=0;
      g_enable=1;
      dumpNum=0;
      inNum=0;
    end
    XOR1: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      newKey[31:0]=oldKey[31:0]^gReturn;
      addr=16;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    XOR2: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      newKey[63:32]=oldKey[63:32]^newKey[31:0];
      addr=16;
      dump=0;
      g_enable=0;
      init=0;
      dumpNum=0;
      inNum=0;
    end
    XOR3: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      newKey[95:64]=oldKey[95:64]^newKey[63:32];
      addr=16;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    XOR4: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      newKey[127:96]=oldKey[127:96]^newKey[95:64];
      addr=16;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    PREPSRAM: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=16;
      newKey=oldKey;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    WRITESRAM: begin
      tmp=0;
      read=0;
      write=1;
      expansionDone=0;
      addr=16;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    DUMPSRAM: begin
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
    end
    DONE: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=1;//probably need a new state for this after everything has been stored in sram
      dump=0;
      addr=16;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
    default: begin//same as IDLE
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=0;
      dump=0;
      init=0;
      g_enable=0;
      dumpNum=0;
      inNum=0;
    end
  endcase
end

always @ (currState, enable, oldKey, roundNum, g_done) begin
  case(currState)
    IDLE: begin
      if(enable)
        nextState=INITSRAM;//maybe a load state
    end
    INITSRAM: begin
      nextState=CHECKROUND;
    end
    READSRAM1: begin
      nextState=PREPSRAM;
    end
    READSRAMELSE: begin
      nextState=G;
    end
    CHECKROUND: begin
      if(roundNum==1) begin
        nextState=READSRAM1;
      end else begin
        nextState=READSRAMELSE;
      end
    end
    G: begin
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
      nextState=WRITESRAM;//may need more than one clock cycle?????
    end
    PREPSRAM: begin
      nextState=WRITESRAM;
    end
    WRITESRAM: begin
      nextState=DUMPSRAM;
    end
    DUMPSRAM: begin
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