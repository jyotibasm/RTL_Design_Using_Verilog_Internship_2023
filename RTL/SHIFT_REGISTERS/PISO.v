// PISo - Paralel In Serial Out 
module piso(
	input reset,ctrl,clk,
	input [3:0] data_in,
	output reg data_out
);
reg [3:0] Reg;
always @(posedge clk)
begin
	if(reset) Reg <= 4'b0;
	else 
	begin
		if(ctrl) // Load Data parallely 
		begin
			Reg <= data_in;
		end 
		else 	// Serial Out 
		begin
			Reg <= Reg >> 1;
			data_out <= Reg[0];
		end
	end 
end
endmodule

// Test Bench
module tb;
	reg reset,ctrl,clk;
	reg [3:0] data_in;
	wire data_out;
 always #1 clk = ~ clk;
 piso s3(reset,ctrl,clk,data_in,data_out);
 initial 
 begin
 clk = 1;
 $monitor($time,"clk=%b,reset=%b,ctrl=%b,data_in=%b,data_out=%b",clk,reset,ctrl,data_in,data_out);
 reset = 1;
 #2 reset = 0; ctrl=1; data_in = 4'd6;
 #2 ctrl = 0;	
 end
 initial begin #50 $finish; end 
endmodule  
