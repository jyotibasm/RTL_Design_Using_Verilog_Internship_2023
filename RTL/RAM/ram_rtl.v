//---------------------RAM 8*8 2^^n*m---------------//
/* -RAM is having 8 Elemets each of 8 Bit Data
   - Input Data 8 Bit
   - Output 8 Bit
   - Address 3 Bit  
*/
module ram(clk,en,rw,data_in,address,data_out);
 // Ports List
 input clk,en,rw;
 input [2:0] address;
 input [7:0] data_in;
 output reg [7:0] data_out;
 
 // Memory 
 reg [7:0] memory [7:0];
 
 always @(posedge clk)
 begin
 	if(en)
	begin
        if(!rw)
	begin
		memory [address] <= data_in;
	end
	else 
	begin
		data_out <= memory [address];
	end 
	end
 end 
endmodule



// Test Bench 
module tb;
 reg clk,en,rw;
 reg [7:0] data_in;
 reg [3:0] address;
 wire [7:0] data_out;
 always #1 clk= ~clk;
 ram r1(clk,en,rw,data_in,address,data_out);
 initial begin
 clk=1;
 $monitor($time,"data_in=%d, Address=%b,data_out=%d",data_in,address,data_out);

 en=0; en=1;  

 #5 rw=0; address=8'd0; data_in=8'd11;
 #5 rw=1;

 #5 rw=0; address=8'd1; data_in=8'd10;
 #5 rw=1;

 #5 rw=0; address=8'd2; data_in=8'd15;
 #5 rw=1;

 end
 initial begin
 #50 $finish;
 end
endmodule 
