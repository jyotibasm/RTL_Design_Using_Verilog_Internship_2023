// 4 Bit MAC - Multiplier & Accumulator Unit 
module mac(x,y,clk,reset,accu,result);
 input [3:0] x,y;
 input clk,reset;
 output reg [7:0] result,accu;	
 reg [7:0] mul,a;
 reg [3:0] op1,op2;

 initial 
 begin
  a = 0;
 end 

 always @(posedge clk)
 begin
	op1 = x;
	op2 = y;
 	if(reset)
 	begin
		op1 = 0; op2 = 0;
		accu = 0;
 	end
 	else 
 	begin
     		mul = op1 * op2;
     		a = a  + mul;
     		result = a;
     		accu =  mul;
	end 
end 
endmodule 

// Test Bench
module tb;
 reg clk,reset;
 reg [3:0] x,y;
 wire [7:0]result,accu;
always #1 clk = ~ clk;
mac m1(x,y,clk,reset,accu,result);
initial begin
	clk = 1;
	$monitor($time,"reset=%b,x=%d, y=%d,accu=%d,result=%d",reset,x,y,accu,result);
        
       reset = 0; x = 4'd1; y = 4'd2;
      #2 x = 4'd1; y = 4'd3;
      #2  reset=1;x = 4'd1; y = 4'd5;
      #2 reset=0;x = 4'd1; y = 4'd3;
end 
initial begin
 #10 $finish;
end 
endmodule 
