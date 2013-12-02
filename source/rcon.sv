module rcon(
  input wire [3:0] roundNum,
  output wire [7:0] out
);

assign out=(roundNum==2 ? 8'h01 : //roundNum is +1 current round num, with 0 being round 10
           (roundNum==3 ? 8'h02 :
           (roundNum==4 ? 8'h04 :
           (roundNum==5 ? 8'h08 :
           (roundNum==6 ? 8'h10 :
           (roundNum==7 ? 8'h20 :
           (roundNum==8 ? 8'h40 :
           (roundNum==9 ? 8'h80 :
           (roundNum==10 ? 8'h1B : 8'h36)))))))));

//out=(roundNum==1 ? 1 :
//    (roundNum==2 ? 2 :
    

endmodule