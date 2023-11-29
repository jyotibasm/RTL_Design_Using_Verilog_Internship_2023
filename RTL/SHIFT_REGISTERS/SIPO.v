/*------------------SISO-------------------------*/
// MAIN MODULE 
module siso(clk,rst,din,dout);
	input clk,rst,din;
	output reg dout;
	reg [3:0] temp;
always @(posedge clk,rst,din) begin	

	if(rst) temp <= 1'b0;
	else begin
	 temp <= temp >>1;
         temp[3] <= din;
	end 
        dout <= temp;	
end 
endmodule 

// TEST BENCH 
module tb;
 reg clk=0,din,rst;
 wire dout;
 siso sr(clk,rst,din,dout);
 always #5 clk=~clk;
 initial begin
 $monitor($time,"in=%b,reset=%b,q=%b",din,rst,dout);
 @(posedge clk) rst=1;din=0;
 @(posedge clk) rst=0;din=1;
 @(posedge clk) din=1;
 @(posedge clk) din=1;
 @(posedge clk) din=0;
 @(posedge clk) din=0;
 @(posedge clk) din=1;
 @(posedge clk) din=1;
 @(posedge clk) din=0;
 @(posedge clk) din=0;
 @(posedge clk) din=1;
 @(posedge clk) din=0;
 @(posedge clk) din=1;
 @(posedge clk) din=1;
 end
initial begin
 #300 $finish;
end 
endmodule
