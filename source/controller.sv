module controller
(
	input wire clk,
	input wire n_rst,
	input wire addrMatch,
	input wire HSELx,
	input wire mWrite,
	input wire dataReady,
	input wire mRead,
	input wire finished,
	input wire keyexp_finished,
	input wire sbytes_finished,
	input wire srows_finished,
	input wire mcol_finished,
	input wire around_finished,
	output reg HREADYOUT,
	output reg readk_enable,
	output reg read_enable,
	output reg write_enable,
	output reg keyexp_enable,
	output reg sbytes_enable,
	output reg srows_enable,
	output reg mcol_enable,
	output reg around_enable
);
	reg lastround;
	reg firstround;
	reg roundinc;

	typedef enum bit [4:0] {IDLEk, RADDRk, WAITk, READDATAk, IDLE, RADDR, WAIT, READDATA, CHECK, KEYEXP, SBYTES, SROWS, MCOL, AROUND, DONE, SEND} stateType;
	stateType state, nextstate;

	always@(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			state <= IDLEk;
		end else begin
			state <= nextstate;
		end
	end

	flex_counter DUT (.clk(clk), .n_rst(n_rst), .count_enable(roundinc), .rollover_val(4'b1001), .sync(1'b0), .rollover_flag(lastround));

	//First derived key = First round : AddRoundKey
	//Second derived key = Second round : SubBytes, ShiftRows, MixColumns, AddRoundKey
	//...
	//Ninth derived key = Ninth round : SubBytes, ShiftRows, MixColumns, AddRoundKey
	//Tenth derived key = Tenth round : SubBytes, ShiftRows, AddRoundKey

	always@(state, addrMatch, HSELx, mWrite, dataReady, mRead, finished, keyexp_finished, sbytes_finished, srows_finished, mcol_finished, around_finished) begin
		nextstate = state;
		case(state)
			IDLEk:
			begin
				if(HSELx == 1'b1) begin
					nextstate = RADDRk;
				end
			end
			RADDRk:
			begin
				if(addrMatch && mWrite) begin
					nextstate = WAITk;
				end
			end
			WAITk:
			begin
				if(dataReady == 1'b1) begin
					nextstate = READDATAk;
				end
			end
			READDATAk:
			begin
				nextstate = IDLE;
			end
			IDLE:
			begin
				if(HSELx == 1'b1) begin
					nextstate = RADDR;
				end
			end
			RADDR:
			begin
				if(addrMatch == 1'b0) begin
					nextstate = IDLE;
				end else if(addrMatch && mRead) begin
					nextstate = SEND;
				end else if(addrMatch && mWrite) begin
					nextstate = WAIT;
				end
			end
			WAIT:
			begin
				if(dataReady == 1'b1) begin
					nextstate = READDATA;
				end
			end
			READDATA:
			begin
				nextstate = CHECK;
			end
			CHECK:
			begin
				if(finished == 1'b0) begin
					nextstate = KEYEXP;
				end else begin
					nextstate = DONE;
				end
			end
			KEYEXP:
			begin
				if(keyexp_finished == 1'b1) begin
					if(!firstround) begin
						nextstate = SBYTES;
					end else begin
						nextstate = AROUND;
					end
				end
			end
			SBYTES:
			begin
				if(sbytes_finished == 1'b1) begin
					nextstate = SROWS;
				end
			end
			SROWS:
			begin
				if(srows_finished == 1'b1) begin
					if(!lastround) begin
						nextstate = MCOL;
					end else begin
						nextstate = AROUND;
					end
				end
			end
			MCOL:
			begin
				if(mcol_finished == 1'b1) begin
					nextstate = AROUND;
				end
			end
			AROUND:
			begin
				if(around_finished == 1'b1) begin
					nextstate = CHECK;
				end
			end
			DONE:
			begin
				nextstate = IDLE;
			end
			SEND:
			begin
				nextstate = IDLE;
			end
		endcase
	end

	always@(state) begin
		HREADYOUT = 1'b0;
		keyexp_enable = 1'b0;
		srows_enable = 1'b0;
		sbytes_enable = 1'b0;
		around_enable = 1'b0;
		mcol_enable = 1'b0;
		read_enable = 1'b0;
    		readk_enable = 1'b0;
   		write_enable = 1'b0;
		firstround = firstround;
		roundinc = 1'b0;
    		case(state)
      		READDATA:
      		begin
        		read_enable = 1'b1;
			firstround = 1'b1;
      		end
      		READDATAk:
     		begin
        		readk_enable = 1'b1;
      		end
      		KEYEXP:
      		begin
			roundinc = 1'b1;
        		keyexp_enable = 1'b1;
      		end
		SBYTES:
      		begin
        		sbytes_enable = 1'b1;
      		end
      		SROWS:
      		begin
        		srows_enable = 1'b1;
      		end
      		MCOL:
      		begin
        		mcol_enable = 1'b1;
      		end
      		AROUND:
      		begin
			firstround = 1'b0;
        		around_enable = 1'b1;
      		end
      		DONE:
      		begin
        		HREADYOUT = 1'b1;
      		end
      		SEND:
      		begin
        		write_enable = 1'b1;
      		end
    		endcase
  	end
endmodule
