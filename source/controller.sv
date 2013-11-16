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
	output reg HRESP,
	output reg HWDATA,
	output reg HREADYOUT
);

	typedef enum bit [4:0] {IDLEk, RADDRk, WAITk, READDATAk, IDLE, RADDR, WAIT, READDATA, CHECK, KEYEX, SBYTES, SROWS, MCOL, AROUND, DONE, SEND} stateType;
	stateType state, nextstate;

	always@(posedgeclk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			state <= IDLEk;
		end else begin
			state <= nextstate;
		end
	end

	always@(state, addrMatch, HSELx, mWrite, dataReady, mRead, finished, keyxp_finished, sbytes_finished, srows_finished, mcol_finished) begin
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
					nexstate = DONE;
				end
			end
			KEYEXP:
			begin
				if(keyexp_finished == 1'b1) begin
					nextstate = SBYTES;
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
					nextstate = MCOL;
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
				if(mcol_finished == 1'b1) begin
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
		HRESP = 1'b0;
		HREADYOUT = 1'b0;
		
