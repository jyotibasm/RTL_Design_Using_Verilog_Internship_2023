/*--------------------Mealy Finite Sequence Machine --------------------*/
//Sequence - 1101
module seq_detector_1101(input x,clk,rst_n,output z);
 //States - s0,s1,s2,s3
 parameter s0=2'b00;
 parameter s1=2'b01;
 parameter s2=2'b10; 
 parameter s3=2'b11;

 reg [1:0] ps,ns;
 reg z;

 //Sequential Circuit / Memory Element 
 always @(posedge clk or rst_n) begin 
  if(!rst_n) ps <= s0;
  else ps <= ns;
 end 

 //Combinational Logic- NextState & Output 
 always @(ps or ns or x) begin
 	case(ps)
		s0 : begin  ns = x ? s1 : s0;
			       z = x ? 0 : 0; 
		     end  
		s1 : begin  ns = x ? s2 : s0;
			       z = x ? 0 : 0; 
		     end  
		s2 : begin  ns = x ? s2 : s3;
			       z = x ? 0 : 0; 
		     end  
		s3 : begin  ns = x ? s1 : s0;
			       z = x ? 0: 1; 
		     end  
           default : begin z = 1'b0;
			   ns <= s0;
		     end 
	endcase	
 end 
endmodule 

module TB;
  reg clk, rst_n, x;
  wire z;
  
  seq_detector_1101 d(x,clk, rst_n,z);
  initial clk = 0;   
  always #2 clk = ~clk;
    
  initial begin
    $monitor("%0t: x = %0b, z = %0b", $time, x, z);
    #1 rst_n = 0;
    #2 rst_n = 1;
    
    #4 x = 1;
    #4 x = 0;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 1;
    #4 x = 0;
    #20;
    $finish;
  end
endmodule
