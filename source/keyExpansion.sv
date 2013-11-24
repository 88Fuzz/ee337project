module keyExpansion
(
  input wire clk,
  input wire n_rst,
  
  input wire [3:0] roundNum,
  input wire enable,
  output reg [127:0] newKey,
  output reg expansionDone
);

reg [31:0] gReturn;
reg [31:0] gEnter;

reg [127:0] oldKey;
reg tmp;
reg read;
reg write;
reg [15:0] addr;

G gggg(.inputVal(gEnter),
       .roundNum(roundNum),
       .outputVal(gReturn)
       );

testing_sram tttttttt(
              .init_file_number(0),
              .dump_file_number(0),
              .mem_clr(tmp),
              .mem_init(tmp),
              .mem_dump(dump),
              .start_address(tmp),
              .last_address(255),
              .verbose(tmp),
              .read_enable(read),
              .write_enable(write),
              .address(addr),
              .read_data(oldKey),
              .write_data(newKey)
              );

typedef enum bit[4:0] {IDLE, CHECKROUND, G, XOR1, XOR2, XOR3, XOR4, DONE, READSRAM, WRITESRAM, PREPSRAM} stateType;//will need states for loading and unloading SRAM
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
    end
    READSRAM: begin
      tmp=0;
      read=1;
      write=0;
      expansionDone=0;
      addr=0;
    end
    CHECKROUND: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=16;
    end
    G: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=16;
    end
    XOR1: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      newKey[31:0]=oldKey[31:0]^gReturn;
      addr=16;
    end
    XOR2: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      newKey[63:32]=oldKey[63:32]^newKey[31:0];
      addr=16;
    end
    XOR3: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      newKey[95:64]=oldKey[95:64]^newKey[63:32];
      addr=16;
    end
    XOR4: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      newKey[127:96]=oldKey[127:96]^newKey[95:64];
      addr=16;
    end
    PREPSRAM: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
      addr=16;
      newKey=oldKey;
    end
    WRITESRAM: begin
      tmp=0;
      read=0;
      write=1;
      expansionDone=0;
      addr=16;
    end
    DONE: begin
      tmp=0;
      read=0;
      write=0;
      expansionDone=1;//probably need a new state for this after everything has been stored in sram
    end
    default: begin//same as IDLE
      tmp=0;
      read=0;
      write=0;
      expansionDone=0;
    end
  endcase
end

always @ (currState, enable, oldKey, roundNum) begin
  case(currState)
    IDLE: begin
      if(enable)
        nextState=CHECKROUND;//maybe a load state
    end
    CHECKROUND: begin
      if(roundNum==1) begin
        nextState=PREPSRAM;
      end else begin
        gEnter=oldKey[127:96];//THIS MAY BE BACKWARDS
        nextState=G;
      end
    end
    G: begin
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
      nextState=DONE;
    end
    DONE: begin
      nextState=IDLE;//LOAD DATA HERERERE
    end
    default: begin
      nextState=IDLE;
    end
  endcase
end

endmodule