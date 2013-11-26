module testing_sram
(
  input wire read,
  input wire write,
  input wire [15:0] addr,
  input wire dump,
  input wire [2:0] dumpNum,
  input wire [2:0] initNum,
  input wire init,
  input wire [127:0] write_data,
  output wire [127:0] read_data
);
reg tmp=0;
reg [8:0]tmp2=511;

//defparam sRAM.W_DATA_SIZE_WORDS=16;
/*W_ADDR_SIZE_BITS  : natural := 16;    -- Address bus size in bits/pins with addresses corresponding to 
																					-- the starting word of the accesss
		W_WORD_SIZE_BYTES : natural := 1;   	-- Word size of the memory in bytes
		W_DATA_SIZE_WORDS : natural := 1;   	-- Data bus size in "words"
		W_READ_DELAY      : time    := 5 ns; 	-- Delay/latency per read access (total time between start of supplying address and when the data read from memory appears on the r_data port)
																					-- Keep the 5 ns delay for 0.5u on-chip SRAM
		W_WRITE_DELAY     : time    := 5 ns 
*/

on_chip_sram_wrapper #(
              .W_ADDR_SIZE_BITS(16),
              .W_WORD_SIZE_BYTES(1),
              .W_DATA_SIZE_WORDS(16)
            )
            
              sRAM(
              .init_file_number(initNum),
              .dump_file_number(dumpNum),
              .mem_clr(tmp),
              .mem_init(init),
              .mem_dump(dump),
              .start_address(tmp),
              .last_address(tmp2),
              .verbose(tmp),
              .read_enable(read),
              .write_enable(write),
              .address(addr),
              .read_data(read_data),
              .write_data(write_data)
              );

endmodule