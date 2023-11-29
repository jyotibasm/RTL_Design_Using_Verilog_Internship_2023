/*-----------------------MEALY FINITE MACHINE--------------------------------*/
module seq_detector_0110(input clk,rst,x,output reg y);
parameter s0=1;
parameter s1=2;
parameter s2=3;
parameter s3=4;
 reg [1:0] PS,NS;
 always @(posedge clk)
 begin
  if(rst) PS <= 0;
  else PS <= ns \
 end 
endmodule 
