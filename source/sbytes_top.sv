module sbytes_top
(
  input wire clk,
  input wire n_rst,
  input wire sbytes_enable,
  output reg sbytes_finished
);

typedef enum bit[4:0] {IDLE, LOAD1, CALC1, SAVE1,
                             LOAD2, CALC2, SAVE2,
                             LOAD3, CALC3, SAVE3,
                             LOAD4, CALC4, SAVE4,
                             LOAD5, CALC5, SAVE5,
                             LOAD6, CALC6, SAVE6,
                             LOAD7, CALC7, SAVE7,
                             LOAD8, CALC8, SAVE8,
                             LOAD9, CALC9, SAVE9,
                             LOAD10, CALC10, SAVE10,
                             LOAD11, CALC11, SAVE11,
                             LOAD12, CALC12, SAVE12,
                             LOAD13, CALC13, SAVE13,
                             LOAD14, CALC14, SAVE14,
                             LOAD15, CALC15, SAVE15,
                             LOAD16, CALC16, SAVE16, DONE} stateType;//will need states for loading and unloading SRAM
stateType currState, nextState;

reg [7:0] olddata;
reg enable;
reg [7:0] newdata;

sbytes blahhhhhhh
(
  .olddata(olddata),
  .sbytes_enable(enable),
  .newdata(newdata)
);

always @ (posedge clk, negedge n_rst) begin
  if(n_rst==0)
    currState<=IDLE;
  else
    currState<=nextState;
end

always @ (currState) begin
  case(currState) begin
    IDLE: begin
    end
    LOAD1: begin
    end
    CALC1: begin
      olddata=1;
    end
    SAVE1: begin
      olddata=0;
    end
    LOAD2: begin
    end
    CALC2: begin
      olddata=1;
    end
    SAVE2: begin
      olddata=0;
    end
    LOAD3: begin
    end
    CALC3: begin
      olddata=1;
    end
    SAVE3: begin
      olddata=0;
    end
    LOAD4: begin
    end
    CALC4: begin
      olddata=1;
    end
    SAVE4: begin
      olddata=0;
    end
    LOAD5: begin
    end
    CALC5: begin
      olddata=1;
    end
    SAVE5: begin
      olddata=0;
    end
    LOAD6: begin
    end
    CALC6: begin
      olddata=1;
    end
    SAVE6: begin
      olddata=0;
    end
    LOAD7: begin
    end
    CALC7: begin
      olddata=1;
    end
    SAVE7: begin
      olddata=0;
    end
    LOAD8: begin
    end
    CALC8: begin
      olddata=1;
    end
    SAVE8: begin
      olddata=0;
    end
    LOAD9: begin
    end
    CALC9: begin
      olddata=1;
    end
    SAVE9: begin
      olddata=0;
    end
    LOAD10: begin
    end
    CALC10: begin
      olddata=1;
    end
    SAVE10: begin
      olddata=0;
    end
    LOAD11: begin
    end
    CALC11: begin
      olddata=1;
    end
    SAVE11: begin
      olddata=0;
    end
    LOAD12: begin
    end
    CALC12: begin
      olddata=1;
    end
    SAVE12: begin
      olddata=0;
    end
    LOAD13: begin
    end
    CALC13: begin
      olddata=1;
    end
    SAVE13: begin
      olddata=0;
    end
    LOAD14: begin
    end
    CALC14: begin
      olddata=1;
    end
    SAVE14: begin
      olddata=0;
    end
    LOAD15: begin
    end
    CALC15: begin
      olddata=1;
    end
    SAVE15: begin
      olddata=0;
    end
    LOAD16: begin
    end
    CALC16: begin
      olddata=1;
    end
    SAVE16: begin
      olddata=0;
    end
    DONE: begin
    end
    default: begin
    end
  endcase
end

always @ (currState, sbytes_enable) begin
  case(currState) begin
    IDLE: begin
      if(sbytes_enable==1)
        nextState=LOAD1;
    end
    LOAD1: begin
    end
    CALC1: begin
      nextState=SAVE1;
    end
    SAVE1: begin
    end
    LOAD2: begin
    end
    CALC2: begin
      nextState=SAVE2;
    end
    SAVE2: begin
    end
    LOAD3: begin
    end
    CALC3: begin
      nextState=SAVE3;
    end
    SAVE3: begin
    end
    LOAD4: begin
    end
    CALC4: begin
      nextState=SAVE4;
    end
    SAVE4: begin
    end
    LOAD5: begin
    end
    CALC5: begin
      nextState=SAVE5;
    end
    SAVE5: begin
    end
    LOAD6: begin
    end
    CALC6: begin
      nextState=SAVE6;
    end
    SAVE6: begin
    end
    LOAD7: begin
    end
    CALC7: begin
      nextState=SAVE7;
    end
    SAVE7: begin
    end
    LOAD8: begin
    end
    CALC8: begin
      nextState=SAVE8;
    end
    SAVE8: begin
    end
    LOAD9: begin
    end
    CALC9: begin
      nextState=SAVE9;
    end
    SAVE9: begin
    end
    LOAD10: begin
    end
    CALC10: begin
      nextState=SAVE10;
    end
    SAVE10: begin
    end
    LOAD11: begin
    end
    CALC11: begin
      nextState=SAVE11;
    end
    SAVE11: begin
    end
    LOAD12: begin
    end
    CALC12: begin
      nextState=SAVE12;
    end
    SAVE12: begin
    end
    LOAD13: begin
    end
    CALC13: begin
      nextState=SAVE13;
    end
    SAVE13: begin
    end
    LOAD14: begin
    end
    CALC14: begin
      nextState=SAVE14;
    end
    SAVE14: begin
    end
    LOAD15: begin
    end
    CALC15: begin
      nextState=SAVE15;
    end
    SAVE15: begin
    end
    LOAD16: begin
    end
    CALC16: begin
      nextState=SAVE16;
    end
    SAVE16: begin
    end
    DONE: begin
    end
    default: begin
      nextState=IDLE;
    end
  endcase
end

endmodule