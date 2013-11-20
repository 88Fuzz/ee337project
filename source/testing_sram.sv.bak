module testing_sram
(
  input wire read,
  input wire write,
  input wire [15:0] addr,
  input wire [7:0] valueIn,
  input wire dump,
  input wire dumpNum,
  output wire [7:0] valueOut
);

on_chip_sram_wrapper tttttttt(
              .init_file_number(0),
              .dump_file_number(dumpNum),
              .mem_clr(0),
              .mem_init(0),
              .mem_dump(dump),
              .start_address(0),
              .last_address(200),
              .verbose(0),
              .read_enable(read),
              .write_enable(write),
              .address(addr),
              .read_data(valueIn),
              .write_data(valueOut)
              );

endmodule