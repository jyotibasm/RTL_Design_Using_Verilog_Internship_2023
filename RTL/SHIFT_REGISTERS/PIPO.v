// PIPO - Paralel In Serial Out 
module piso(
	input reset,clk,
	input [3:0] data_in,
	output reg [3:0]data_out
);
always @(posedge clk)
begin
	if(reset) data_out <= 4'b0;
	else 
	begin
		data_out <= data_in;
	end 
end
endmodule

// Test Bench
module tb;
	reg reset,clk;
	reg [3:0] data_in;
	wire [3:0]data_out;
 always #1 clk = ~ clk;
 piso s3(reset,clk,data_in,data_out);
 initial 
 begin
 clk = 1;
 $monitor($time,"clk=%b,reset=%b,data_in=%b,data_out=%b",clk,reset,data_in,data_out);
 reset = 1;
 #2 reset = 0; data_in = 4'd6;	
 end
 initial begin #50 $finish; end 
endmodule  
