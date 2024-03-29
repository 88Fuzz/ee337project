module AMBA_inout
(
  input wire HCLK,
  input wire HNRST,
  input wire clk,
  input wire n_rst,
  input wire writek_enable,//master writing key
  input wire writed_enable,//master writing data
  input wire readd_enable,//master reading data
  input wire hresp_error,
  input wire hready_enable,
  input wire HCLK_fall,
  input wire HCLK_rise,
  input wire [127:0] read_data,
  input wire [127:0] HWDATA,
  output reg [127:0] HRDATA,
  output reg [127:0] write_data,
  output wire HREADYOUT,
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

/*testing_sram SexyRandomAccessMemory
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
);*/

reg currHREADYOUT;
reg nextHREADYOUT;
reg [127:0]currHRDATA;
reg [127:0]nextHRDATA;

assign HREADYOUT=currHREADYOUT;
assign HRDATA=currHRDATA;

//                      0            1      2       3             4
typedef enum bit[3:0] {WRITEKSETUP, IDLE, WRITEK, WRITEDSETUP, WRITED,
//                        5           6     7         8       9      10     11
                       READDSETUP, READD, DISPLAYD, HREADY, ERROR, IDLE2, IDLE3,
                       //12    13     14      15
                       WHAT1, WHAT2, WHAT3, WHAT4} stateType;
stateType currState, nextState;

always @(posedge clk, negedge n_rst) begin
  if(n_rst==0) begin
    currState<=IDLE;
    currHREADYOUT<=1;
    currHRDATA<=0;
  end else begin
    currState<=nextState;
    currHREADYOUT<=nextHREADYOUT;
    currHRDATA<=nextHRDATA;
  end
end

always @ (currState, currHREADYOUT, currHRDATA, HWDATA, read_data) begin
  read=0;
  write=0;
  addr=0;
  dumpNum=0;
  initNum=0;
  dump=0;
  init=0;
  //HRDATA=0;
  HRESP=0;
  nextHREADYOUT=currHREADYOUT;
  nextHRDATA=currHRDATA;
  write_data=0;
  case(currState)
    IDLE: begin
      nextHREADYOUT=1;
    end
    WRITEKSETUP: begin
      addr=0;
      write_data=HWDATA;
    end
    WRITEK: begin
      addr=0;
      write=1;
      nextHREADYOUT=0;
      write_data=HWDATA;
    end
    WRITEDSETUP: begin
      addr=32;
      write_data=HWDATA;
    end
    WRITED: begin
      write=1;
      addr=32;
      write_data=HWDATA;
    end
    READDSETUP: begin
      addr=32;
    end
    READD: begin//probably have to wait until the AMBA clock goes high/low
      read=1;
      addr=32;
    end
    DISPLAYD: begin
      nextHRDATA=read_data;
    end
    ERROR: begin
      HRESP=1;
    end
    HREADY: begin
      nextHREADYOUT=0;
    end
    IDLE2: begin
    end
    IDLE3: begin
    end
    WHAT1: begin
    end
    WHAT2: begin
    end
    WHAT3: begin
    end
    WHAT4: begin
    end
    default: begin
      nextHREADYOUT=1;
    end
  endcase
end

always @(currState, writek_enable, writed_enable, readd_enable, hresp_error, hready_enable, HCLK_fall, HCLK_rise) begin
  nextState=currState;
  case(currState)
    IDLE: begin
      nextState=IDLE;
      if(writek_enable) begin
        nextState=WRITEKSETUP;
      end else
      if(writed_enable) begin
        nextState=WRITEDSETUP;
      end else
      if(readd_enable) begin
        nextState=READDSETUP;
      end else
      if(hresp_error) begin
        nextState=ERROR;
      end else
      if(hready_enable) begin
        nextState=HREADY;
      end
    end
    WRITEKSETUP: begin
      nextState=WRITEK;
    end
    WRITEK: begin
      nextState=IDLE2;
    end
    IDLE2: begin
      nextState=IDLE3;
    end
    IDLE3: begin
      nextState=IDLE;
    end
    WRITEDSETUP: begin
        nextState=WRITED;
    end
    WRITED: begin
      nextState=IDLE;
    end
    READDSETUP: begin
      if(HCLK_rise)
        nextState=READD;
      else
        nextState=currState;
    end
    READD: begin//probably have to wait until the AMBA clock goes high/low
      nextState=DISPLAYD;
    end
    DISPLAYD: begin
      nextState=IDLE;
    end
    ERROR: begin
      if(HCLK_fall)//!hresp_error)
        nextState=IDLE;
      /*else if(HCLK_rise)
        nextState=IDLE;*/
      else
        nextState=ERROR;
    end
    HREADY: begin
      if(!hready_enable)
        nextState=IDLE;
      else
        nextState=HREADY;
    end
    WHAT1: begin
      nextState=IDLE;
    end
    WHAT2: begin
      nextState=IDLE;
    end
    WHAT3: begin
      nextState=IDLE;
    end
    WHAT4: begin
      nextState=IDLE;
    end
    default: begin
      nextState=IDLE;
    end
  endcase
end


endmodule