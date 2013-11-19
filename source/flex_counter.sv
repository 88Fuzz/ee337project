// $Id: $
// File name:   flex_counter.sv
// Created:     9/8/2013
// Author:      Kyle Donnelly
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Flexible Counter Specifications

module flex_counter
#(
parameter NUM_CNT_BITS=4
)
(
input wire clk,
input wire n_rst,
input wire count_enable,
input wire [NUM_CNT_BITS-1:0] rollover_val,
input wire sync,                                  //PUT BACK IN
output wire rollover_flag
//output wire [NUM_CNT_BITS-1:0] testStateCnt//DELETE
);

//assign testStateCnt=currState;//DELETE

reg [NUM_CNT_BITS-1:0] currState;
reg [NUM_CNT_BITS-1:0] nextState;
reg currOut;
reg nextOut;


assign rollover_flag=currOut;

always @ (posedge clk, negedge n_rst) begin
//always @ (posedge clk, n_rst) begin
  if(n_rst==0) begin
    currState<=0;
    currOut<=0;
  end else begin
    currState<=nextState;
    currOut<=nextOut;
  end
end

always @ (currState, count_enable, currOut, rollover_val, sync) begin
  if(count_enable==1) begin
    if(currState < rollover_val) begin
      nextState=currState+1;
      nextOut=0;
    end else begin//if((currState+1)==rollover_val) begin
      nextOut=currOut;
      nextState=currState;
    end
    
    if((currState+1)==rollover_val) begin
      nextOut=1;
      nextState=0;//=1;
    end /*else begin
      nextOut=currOut;
      nextState=currState;
    end*/
    
  end else begin
    nextState=currState;
    nextOut=currOut;
  end
  
  if(sync) begin
    nextState=0;
    nextOut=0;
  end
end


endmodule
