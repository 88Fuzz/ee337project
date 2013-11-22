`timescale 1ns / 10ps

module tb_pts128to8 ();
  
localparam CLK_PERIOD = 2.5;   
  
reg tb_clk;
reg tb_rst;
reg tb_shift_enable;
reg tb_load_enable; 
reg [127:0]parallelinput; 
reg [7:0]paralleloutput; 
integer i; 
integer k; 

  pts128to8 TEST 
( .clk(tb_clk), .n_rst(tb_rst), .shift_enable(tb_shift_enable), .load_enable(tb_load_enable), .parallel_in(parallelinput), .serial_out(paralleloutput));

	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	initial 
	 begin
	   
	   tb_rst = 1; 
	   
	   #(CLK_PERIOD*2)
	   
	   for ( i = 0; i < 64; i = i + 1 ) begin
	     parallelinput[i*2] = 1; 
	     parallelinput[(i*2)+1] = 0; 
	   end 
	   
	   
	   #(CLK_PERIOD*2)
	   
	   tb_load_enable = 1; 
	   
	   #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 1");
	   else 
	     $error("FAILED 1");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 2");
	   else 
	     $error("FAILED 2");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 3");
	   else 
	     $error("FAILED 3");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 4");
	   else 
	     $error("FAILED 4");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 5");
	   else 
	     $error("FAILED 5");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 6");
	   else 
	     $error("FAILED 6");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 7");
	   else 
	     $error("FAILED 7");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 8");
	   else 
	     $error("FAILED 8");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 9");
	   else 
	     $error("FAILED 9");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 10");
	   else 
	     $error("FAILED 10");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 11");
	   else 
	     $error("FAILED 11");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 12");
	   else 
	     $error("FAILED 12");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 13");
	   else 
	     $error("FAILED 13");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 14");
	   else 
	     $error("FAILED 14");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 15");
	   else 
	     $error("FAILED 15");
	     
	      #(CLK_PERIOD*2)
	   
	   tb_shift_enable = 1; 
	   
	   if ( paralleloutput == 8'b10101010 ) 
	     $info("PASSED 16");
	   else 
	     $error("FAILED 16");
	     
end 

endmodule  
	     
	     
	   
	   
	   
	   
