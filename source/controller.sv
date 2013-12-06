module controller
(
	input wire clk,
	input wire n_rst,
	input wire addrMatch,
	input wire HSELx,
	input wire mWrite,
	input wire dataReady,
	input wire mRead,
	input wire keyexp_finished,
	input wire sbytes_finished,
	input wire srows_finished,
	input wire mcol_finished,
	input wire around_finished,
	input wire invalid,
	output reg HREADYOUT,
	output reg readk_enable,
	output reg read_enable,
	output reg write_enable,
	output reg keyexp_enable,
	output reg sbytes_enable,
	output reg srows_enable,
	output reg mcol_enable,
	output reg around_enable,
	output reg hresp_error,
	output reg [3:0] roundnum
);
	reg lastround;
	reg firstround;
	reg roundinc;
	reg currfirst;
	reg nextfirst;
	reg nextmcol;
	reg currmcol;
	reg nextreadk;
	reg currreadk;
	reg nextread;
	reg currread;
	reg nextwrite;
	reg currwrite;
	reg nextkeyexp;
	reg currkeyexp;
	reg nextsbytes;
	reg currsbytes;
	reg nextsrows;
	reg currsrows;
	reg nextaround;
	reg curraround;
	reg nexthresp;
	reg currhresp;
	reg syncval;
	//reg [3:0] roundnum;

	typedef enum bit [4:0] {IDLEk, RADDRk, Errork, WAITk, READDATAk, IDLE, RADDR, Error, WAIT, READDATA, CHECK, KEYEXP, SBYTES, SROWS, MCOL, AROUND, DONE, SEND} stateType;
	stateType state, nextstate;

	always@(posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			state <= IDLEk;
			currfirst <= 1'b0;
			currmcol <= 1'b0;
			currreadk <= 1'b0;
			currread <= 1'b0;
			currwrite <= 1'b0;
			currkeyexp <= 1'b0;
			currsbytes <= 1'b0;
			currsrows <= 1'b0;
			curraround <= 1'b0;
			currhresp <= 1'b0;
		end else begin
			state <= nextstate;
			currfirst <= nextfirst;
			currmcol <= nextmcol;
			currreadk <= nextreadk;
			currread <= nextread;
			currwrite <= nextwrite;
			currkeyexp <= nextkeyexp;
			currsbytes <= nextsbytes;
			currsrows <= nextsrows;
			curraround <= nextaround;
			currhresp <= nexthresp;
		end
	end

	flex_counter DUT (.clk(clk), .n_rst(n_rst), .count_enable(roundinc), .rollover_val(4'b1011), .sync(syncval), .rollover_flag(lastround), .testStateCnt(roundnum));

	//First derived key = First round : AddRoundKey
	//Second derived key = Second round : SubBytes, ShiftRows, MixColumns, AddRoundKey
	//...
	//Ninth derived key = Ninth round : SubBytes, ShiftRows, MixColumns, AddRoundKey
	//Tenth derived key = Tenth round : SubBytes, ShiftRows, AddRoundKey

	always@(state, addrMatch, HSELx, mWrite, dataReady, mRead, keyexp_finished, sbytes_finished, srows_finished, mcol_finished, around_finished, firstround, lastround, invalid) begin
		case(state)
			IDLEk:
			begin
				if(HSELx == 1'b1) begin
					nextstate = RADDRk;
				end else begin
					nextstate = IDLEk;
				end
			end
			RADDRk:
			begin
				if(invalid == 1'b1) begin
					nextstate = Errork;
				end else if(addrMatch && mWrite) begin
					nextstate = WAITk;
				end else begin
					nextstate = RADDRk;
				end
			end
			Errork:
			begin
				if(HSELx == 1'b1) begin
					nextstate = RADDRk;
				end else begin
					nextstate = Errork;
				end
			end
			WAITk:
			begin
				if(dataReady == 1'b1) begin
					nextstate = READDATAk;
				end else begin
					nextstate = WAITk;
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
				end else begin
					nextstate = IDLE;
				end
			end
			RADDR:
			begin
				if(invalid == 1'b1) begin
					nextstate = Error;
				end else if(addrMatch == 1'b0) begin
					nextstate = IDLE;
				end else if(addrMatch && mRead) begin
					nextstate = SEND;
				end else if(addrMatch && mWrite) begin
					nextstate = WAIT;
				end else begin
					nextstate = RADDR;
				end
			end
			Error:
			begin
				if(HSELx == 1'b1) begin
					nextstate = RADDR;
				end else begin
					nextstate = Error;
				end
			end
			WAIT:
			begin
				if(dataReady == 1'b1) begin
					nextstate = READDATA;
				end else begin
					nextstate = WAIT;
				end
			end
			READDATA:
			begin
				nextstate = CHECK;
			end
			CHECK:
			begin
				if(lastround == 1'b0) begin
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
				end else begin
					nextstate = KEYEXP;
				end
			end
			SBYTES:
			begin
				if(sbytes_finished == 1'b1) begin
					nextstate = SROWS;
				end else begin
					nextstate = SBYTES;
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
				end else begin
					nextstate = SROWS;
				end
			end
			MCOL:
			begin
				if(mcol_finished == 1'b1) begin
					nextstate = AROUND;
				end else begin
					nextstate = MCOL;
				end
			end
			AROUND:
			begin
				if(around_finished == 1'b1) begin
					nextstate = CHECK;
				end else begin
					nextstate = AROUND;
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
			default:
			begin
				nextstate = IDLEk;
			end
		endcase
	end

	assign firstround = currfirst;
	assign mcol_enable = currmcol;
	assign around_enable = curraround;
	assign sbytes_enable = currsbytes;
	assign srows_enable = currsrows;
	assign keyexp_enable = currkeyexp;
	assign readk_enable = currreadk;
	assign read_enable = currread;
	assign write_enable = currwrite;
	assign hresp_error = currhresp;

	always@(state, currfirst) begin
		HREADYOUT = 1'b0;
		nextkeyexp = 1'b0;
		nextsrows = 1'b0;
		nextsbytes = 1'b0;
		nextaround = 1'b0;
		nextread = 1'b0;
		nextreadk = 1'b0;
		nextwrite = 1'b0;
		nextmcol = 1'b0;
		nextfirst = currfirst;
		roundinc = 1'b0;
		nexthresp = 1'b0;
		syncval = 1'b0;
    		case(state)
      		READDATA:
      		begin
        		//read_enable = 1'b1;
			nextread = 1'b1;
			nextfirst = 1'b1;
      		end
      		READDATAk:
     		begin
        		//readk_enable = 1'b1;
			nextreadk = 1'b1;
      		end
		Errork:
		begin
			//hresp_error = 1'b1;
			nexthresp = 1'b1;
		end
		Error:
		begin
			//hresp_error = 1'b1;
			nexthresp = 1'b1;
		end
		CHECK:
		begin
			roundinc = 1'b1;
		end
      		KEYEXP:
      		begin
			//roundinc = 1'b1;
        		//keyexp_enable = 1'b1;
			nextkeyexp = 1'b1;
      		end
		SBYTES:
      		begin
        		//sbytes_enable = 1'b1;
			nextsbytes = 1'b1;
      		end
      		SROWS:
      		begin
        		//srows_enable = 1'b1;
			nextsrows = 1'b1;
      		end
      		MCOL:
      		begin
        		//mcol_enable = 1'b1;
			nextmcol = 1'b1;
      		end
      		AROUND:
      		begin
			nextfirst = 1'b0;
        		//around_enable = 1'b1;
			nextaround = 1'b1;
      		end
      		DONE:
      		begin
        		HREADYOUT = 1'b1;
			nextfirst = 1'b1;
			syncval = 1'b1;
      		end
      		SEND:
      		begin
        		//write_enable = 1'b1;
			nextwrite = 1'b1;
      		end
    		endcase
  	end
endmodule
