// up Counter
module upc(input clk,rst,output reg [3:0] count);
 always @(posedge clk) begin
  if(rst | count >= 9) count <= 0;
  else count <= count + 1;
 end 
endmodule

// Test Bench
module tb;
 reg clk,rst; 
 wire [3:0] count;
 always #5 clk=~clk;
 upc d1(clk,rst,count);
 initial begin
 clk=0;
 $monitor($time,"count=%b",count); 
 #1; 
 rst=1;
 #1;
 rst =0;
 end 
 initial begin
 #200; $finish;
 end 
endmodule 
