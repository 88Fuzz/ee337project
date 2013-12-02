module addround_top
(
  input wire clk; 
  input wire n_rst; 
  input wire around_enable,
  output reg round_done
  ); 
  
  reg read;
  reg write;
  reg [15:0] addr;
  reg [127:0] valueIn;
  reg dump;
  reg in;
  reg dumpNum = 0;
  reg inNum = 0;
  reg [127:0] valueOut;  
  reg [127:0] valueBuffer; 
  
  
  testing_sram DUT
(
  .read(read),
  .write(write),
  .addr(addr),
  .valueIn(valueIn),
  .dump(dump),
  .dumpNum(dumpNum),
  .in(in),
  .inNum(inNum),
  .valueOut(valueOut)
);

addround WOAH
(

)

typedef enum {IDLE,INITSRAM,READSRAM1,READSRAM2,TEMPSTORE,ADDROUND1,ADDROUND2,ADDROUND3,ADDROUND4,ADDROUND5,ADDROUND6,ADDROUND7,ADDROUND8,ADDROUND9,ADDROUND10,ADDROUND11,ADDROUND12,ADDROUND13,ADDROUND14,ADDROUND15,ADDROUND16,WRITINGSRAM,DUMPSRAM} stateType;

stateType state, nxt_state;
   
   always @ (posedge clk, negedge n_rst) begin 
     
      if (n_rst == 0) begin
	     state <= IDLE;
      end
      
      else
	     state <= nxt_state;
      end
      
      
   always @ (state) begin 
   
   case(state)
   IDLE: begin 
     read = 0; 
     write = 0; 
     addr = 0; 
     valueIn = 0; 
     dump = 0; 
     in = 0; 
   end 
       
     
   INITSRAM: begin
     read = 0; 
     write = 0; 
     addr = 16; 
     valueIn = 0; 
     dump = 0; 
     in = 1; 
   end 
   
   READSRAM1: begin 
     read = 1;
     write = 0; 
     addr = 16;
     valueIn = 0; 
     dump = 0; 
     in = 0; 
   end
   
   TEMPSTORE: begin 
     read = 0; 
     write = 0;
     addr = 48;
     valueIn = 0; 
     dump = 0; 
     in = 0; 
     valueBuffer = valueOut; 
  end  
     
   
   READSRAM1: begin 
     read = 1;
     write = 0; 
     addr = 48;
     valueIn = 0; 
     dump = 0; 
     in = 0; 
   end 
   
   ADDROUND1: begin
     read = 0; 
     write = 0; 
     addr = 0; 
     valueIn = 0;
     dump = 0; 
     in = 0; 
   
   
      
     
     
       