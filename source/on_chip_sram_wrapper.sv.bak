module on_chip_sram_wrapper
(
        input wire mem_clr,
        input wire mem_init,
        input wire mem_dump,
        input wire verbose,
        input wire init_file_number,
        input wire dump_file_number,
        input wire start_address,
        input wire last_address,
        input wire read_enable,
        input wire write_enable,
        input wire address,
        input wire read_data,
        input wire write_data
 
);

simple_scale_mem TEST
(
	.mem_clr(mem_clr),
	.mem_init(mem_init),
	.mem_dump(mem_dump),
	.verbose(verbose),
	.init_file_number(init_file_number),
	.dump_file_number(dump_file_number),
	.start_address(start_address),
	.last_address(last_address),
	.read_enable(read_enable),
	.write_enable(write_enable),
	.address(address),
	.read_data(read_data),
	.write_data(write_data) 
);

endmodule
