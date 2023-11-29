// Down Counter
module downc(input clk,rst,output reg [3:0] count);
 initial count <= 15;
 always @(posedge clk) begin
  if(rst) count <= 15;
  else count <= count - 1;
 end 
endmodule

// Test Bench
module tb;
 reg clk,rst; 
 wire [3:0] count;
 always #5 clk=~clk;
 downc d1(clk,rst,count);
 initial begin
 clk=1;
 $monitor($time,"count=%b",count); 
 #1; 
 rst=1;
 #1;
 rst =0;
 end 
 initial begin
 #50; $finish;
 end 
endmodule 
