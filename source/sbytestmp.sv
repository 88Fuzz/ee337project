module sbytestmp
(
  input wire clk,
  input wire n_rst,
  input wire sbytes_enable,
  output reg sbytes_finished
);

typedef enum bit [1:0] {IDLE, DONE} stateType;
	stateType currState, nextState;

	always@(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			currState<=IDLE;
		end else begin
			currState<=nextState;
		end
	end
	
	always @(currState, sbytes_enable) begin
	  case(currState)
	    IDLE: begin
	      if(sbytes_enable) begin
	        nextState=DONE;
	      end else begin
	        nextState=IDLE;
	      end
	    end
	    DONE: begin
	      nextState=IDLE;
	    end
	    default: begin
	      nextState=IDLE;
	     end
    endcase
	end
	
	always @(currState) begin
	  case(currState)
	    IDLE:begin
	      sbytes_finished=0;
	    end
	    DONE: begin
	      sbytes_finished=1;
	    end
	    default: begin
	      sbytes_finished=0;
	    end
	  endcase
	end
	
endmodule