module tb;
 reg i0,i1,s;
 wire y;
 mux21 m1(i0,i1,s,y);
 initial begin
   i0=0; i1=1;
  $monitor($time,"i0=%b,i1=%b,s=%b,y=%b",i0,i1,s,y);
   #5;
   s=0;
   #5;
   s=1; 
 end
endmodule 

