module keyExpansion
(
  input wire clk,
  input wire n_rst,
  input wire [127:0] oldKey,
  input wire [3:0] roundNum,
  input wire enable,
  output reg [127:0] newKey,
  output reg expansionDone
);

reg [31:0] gReturn;
reg [31:0] gEnter;

reg tmp;
reg read;
reg write;
reg [15:0] addr;
reg [7:0] sramOut;
reg [7:0] sramIn;

G gggg(.inputVal(gEnter),
       .roundNum(roundNum),
       .outputVal(gReturn)
       );

on_chip_sram_wrapper tttttttt(
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
              .read_data(sramOut),
              .write_data(sramIn)
              );

typedef enum bit[4:0] {IDLE, CHECKROUND, G, XOR1, XOR2, XOR3, XOR4, DONE} stateType;//will need states for loading and unloading SRAM
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
      expansionDone=0;
    end
    CHECKROUND: begin
      expansionDone=0;
    end
    G: begin
      expansionDone=0;
    end
    XOR1: begin
      expansionDone=0;
      newKey[31:0]=oldKey[31:0]^gReturn;
    end
    XOR2: begin
      expansionDone=0;
      newKey[63:32]=oldKey[63:32]^newKey[31:0];
    end
    XOR3: begin
      expansionDone=0;
      newKey[95:64]=oldKey[95:64]^newKey[63:32];
    end
    XOR4: begin
      expansionDone=0;
      newKey[127:96]=oldKey[127:96]^newKey[95:64];
    end
    DONE: begin
      expansionDone=1;//probably need a new state for this after everything has been stored in sram
    end
    default: begin//same as IDLE
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
      if(roundNum==0)
        gEnter=0;
      if(roundNum!=0)
        gEnter=oldKey[127:96];//THIS MAY BE BACKWARDS
        nextState=G;
    end
    G: begin
      nextState=XOR1;
    end
    XOR1: begin
      nextState=XOR1;//may need more than one clock cycle?????
    end
    XOR2: begin
      nextState=XOR2;//may need more than one clock cycle?????
    end
    XOR3: begin
      nextState=XOR3;//may need more than one clock cycle?????
    end
    XOR4: begin
      nextState=XOR4;//may need more than one clock cycle?????
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