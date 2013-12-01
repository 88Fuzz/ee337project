module AMBA_inout
(
  input wire clk,
  input wire n_rst,
  input wire writek_enable,//master writing key
  input wire writed_enable,//master writing data
  input wire readd_enable,//master reading data
  input wire hresp_error,
  input wire hready_enable,
  input wire [127:0] read_data,
  input wire [127:0] HWDATA,
  output reg [127:0] HRDATA,
  output reg [127:0] write_data,
  output reg HREADYOUT,
  output reg HRESP,
  output reg read,
  output reg write,
  output reg [15:0] addr,
  output reg dump,
  output reg [2:0] dumpNum,
  output reg [2:0] initNum,
  output reg init
);

//reg [127:0] read_data;
//reg [127:0] write_data;
//reg read;
//reg write;
//reg [15:0] addr;
//reg dump;
//reg [2:0]dumpNum;
//reg [2:0]initNum;
//reg init;

testing_sram SexyRandomAccessMemory
(
  .read(read),
  .write(write),
  .addr(addr),
  .dump(dump),
  .dumpNum(dumpNum),
  .initNum(initNum),
  .init(init),
  .write_data(write_data),
  .read_data(read_data)
);



typedef enum bit[3:0] {IDLE,WRITEKSETUP, WRITEK, WRITEDSETUP, WRITED, READDSETUP, READD, HREADY, ERROR} stateType;
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
      read=0;
      write=0;
      addr=0;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=0;
    end
    WRITEKSETUP: begin
      read=0;
      write=0;
      addr=0;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=HWDATA;
    end
    WRITEK: begin
      read=0;
      write=1;
      addr=0;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=HWDATA;
    end
    WRITEDSETUP: begin
      read=0;
      write=0;
      addr=32;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=HWDATA;
    end
    WRITED: begin
      read=0;
      write=1;
      addr=32;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=HWDATA;
    end
    READDSETUP: begin
      read=0;
      write=0;
      addr=32;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=0;
    end
    READD: begin//probably have to wait until the AMBA clock goes high/low
      read=1;
      write=0;
      addr=32;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=0;
    end
    ERROR: begin
      read=0;
      write=0;
      addr=0;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=1;
      write_data=0;
    end
    HREADY: begin
      read=0;
      write=0;
      addr=0;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=0;
    end
    default: begin
      read=0;
      write=0;
      addr=0;
      dumpNum=0;
      initNum=0;
      dump=0;
      init=0;
      HRDATA=0;
      HREADYOUT=0;
      HRESP=0;
      write_data=0;
    end
  endcase
end

always @(currState, writek_enable, writek_enable, readd_enable, hresp_error, hready_enable) begin
  case(currState)
    IDLE: begin
      if(writek_enable)
        nextState=WRITEKSETUP;
      else if(writed_enable)
        nextState=WRITEDSETUP;
      else if(readd_enable)
        nextState=READDSETUP;
      else if(hresp_error)
        nextState=ERROR;
      else if(hready_enable)
        nextState=HREADY;
      else
        nextState=IDLE;
    end
    WRITEKSETUP: begin
      nextState=WRITEK;
    end
    WRITEK: begin
      nextState=IDLE;
    end
    WRITEDSETUP: begin
      nextState=WRITED;
    end
    WRITED: begin
      nextState=IDLE;
    end
    READDSETUP: begin
      nextState=READD;
    end
    READD: begin//probably have to wait until the AMBA clock goes high/low
      nextState=IDLE;
    end
    ERROR: begin
      if(!hresp_error)
        nextState=IDLE;
    end
    HREADY: begin
      if(!hready_enable)
        nextState=IDLE;
    end
    default: begin
      nextState=IDLE;
    end
  endcase
end


endmodule