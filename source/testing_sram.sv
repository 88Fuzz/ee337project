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
reg tmp=0;
reg [7:0]tmp2=200;
on_chip_sram_wrapper tttttttt(
              .init_file_number(0),
              .dump_file_number(dumpNum),
              .mem_clr(tmp),
              .mem_init(tmp),
              .mem_dump(dump),
              .start_address(tmp),
              .last_address(tmp2),
              .verbose(tmp),
              .read_enable(read),
              .write_enable(write),
              .address(addr),
              .read_data(valueOut),
              .write_data(valueIn)
              );

endmodule