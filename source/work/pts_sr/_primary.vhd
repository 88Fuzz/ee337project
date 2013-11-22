library verilog;
use verilog.vl_types.all;
entity pts_sr is
    generic(
        NUM_BITS        : integer := 128;
        NUM_OUT         : integer := 8;
        SHIFT_MSB       : integer := 1
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        shift_enable    : in     vl_logic;
        load_enable     : in     vl_logic;
        parallel_in     : in     vl_logic_vector;
        serial_out      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_BITS : constant is 1;
    attribute mti_svvh_generic_type of NUM_OUT : constant is 1;
    attribute mti_svvh_generic_type of SHIFT_MSB : constant is 1;
end pts_sr;
