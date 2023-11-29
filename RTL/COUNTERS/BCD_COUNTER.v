// BCD Counter 
module bcd(input CLK,RESET,output reg [3:0] COUNT);
 always @(posedge CLK) begin
 	if( RESET | COUNT>=9 ) COUNT <=0;
	else COUNT <= COUNT + 1;
 end 
endmodule 
