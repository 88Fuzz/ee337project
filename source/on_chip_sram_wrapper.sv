module on_chip_sram_wrapper
(
  
);

port
	(
		-- Test bench control signals
		init_file_number	: in natural;	-- The number of the initialization file name to use during the next requested memory init
																		-- Only use values from 0 thru (2^31 - 1) as naturals are simply the postive range of a signed 32-bit integer
		dump_file_number	: in natural;	-- The number of the dump file name to use during the next requested memory dump
																		-- Only use values from 0 thru (2^31 - 1) as naturals are simply the postive range of a signed 32-bit integer
		mem_clr       : in  boolean;		-- Strobe this for at least 1 simulation timestep to zero all memory contents
    mem_init      : in  boolean;		-- Strobe this for at least 1 simulation timestep to set the values for addresses
																		-- currently selected init file to their corresponding values precribed in the file
    mem_dump      : in  boolean;		-- Strobe this for at least 1 simulation timestep to dump all values modified since
																		-- the most recent mem_clr activation.
																		-- Only the locations between the "start_address" and "last_address" (inclusive) will be printed
    start_address : in  natural;		-- The first address to start dumping memory contents from
    last_address  : in  natural;		-- The last address to dump memory contents from
    verbose       : in  boolean;		-- Active high enable for more verbose debugging information
		
		-- Memory interface signals (read enable, write enable, address of first word in the access, data from a read, data supplied for a write)
		read_enable		: in	std_logic;
		write_enable	: in	std_logic;
		address				: in	std_logic_vector((W_ADDR_SIZE_BITS - 1) downto 0);
		read_data			: out	std_logic_vector(((W_DATA_SIZE_WORDS * W_WORD_SIZE_BYTES * 8) - 1) downto 0);
		write_data		: in	std_logic_vector(((W_DATA_SIZE_WORDS * W_WORD_SIZE_BYTES * 8) - 1) downto 0)
	);
endmodule
