module AMBA_inout
(
  input wire clk,
  input wire n_rst,
  input wire readk_enable,
  input wire read_enable,
  input wire write_enable,
  input wire hresp_error,
  input wire hready_enable,
  input wire [127:0] HWDATA,
  output reg [127:0] HRDATA,
  output reg HREADYOUT,
  output reg HRESP
);

reg [127:0] inData;
reg [127:0] outData;

typedef enum bit[3:0] {IDLE,READK,READD,WRITED,HREADY,ERROR} stateType;
stateType currState, nextState;

always @(posedge clk, negedge n_rst) begin
  if(n_rst==0) begin
    currState<=IDLE;
  end else begin
    currState<=nextState;
  end
end

always @ (currState) begin
  case(currState)
    IDLE: begin
      HREADYOUT=0;
      HRESP=0;
    end
    READK: begin
      inData=HWDATA;
      //TODO FIGURE OUT SRAM
      HREADYOUT=0;
      HRESP=0;
    end
    READD: begin
      inData=HWDATA;
      //TODO FIGURE OUT SRAM
      HREADYOUT=0;
      HRESP=0;
    end
    WRITED: begin
      //TODO FIGURE OUT SRAM
      HREADYOUT=0;
      HRESP=0;
    end
    HREADY: begin
      HREADYOUT=1;
      HRESP=0;
    end
    ERROR: begin
      HREADYOUT=0;
      HRESP=0;
    end
    default: begin
      HREADYOUT=0;
      HRESP=0;
    end
  endcase
end

always @(currState, readk_enable, read_enable, write_enable, hresp_error) begin
  case(currState)
    IDLE: begin
      if(readk_enable)
        nextState=READK;
      else if(read_enable)
        nextState=READD;
      else if(write_enable)
        nextState=WRITED;
      else if(hresp_error)
        nextState=ERROR;
      else if(hready_enable)
        nextState=HREADY;
      else
        nextState=IDLE;
    end
    READK: begin
      if(!readk_enable)
        nextState=IDLE;
    end
    READD: begin
      if(!read_enable)
        nextState=IDLE;
    end
    WRITED: begin
      if(!write_enable)
        nextState=IDLE;
    end
    ERROR: begin
      if(!hresp_error)
        nextState=IDLE;
    end
    default: begin
      nextState=IDLE;
    end
  endcase
end



/*    if(readk_enable) begin
      //TODO FIGURE OUT HOW TO PUT SHIT INTO SRAM
    end else if(read_enable) begin
      //TODO FIGURE OUT HOW TO PUT SHIT INTO SRAM
    end else if(write_enable) begin
      //FIGURE OUT HOW TO GET SHIT FROM SRAM
    end else if(hresp_error) begin
      HRESP<=1;
    end
  end
end*/

endmodule