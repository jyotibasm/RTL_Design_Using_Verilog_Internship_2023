//---------------------ROM 8*8 2^^n*m---------------//
/* - Output 8 Bit
   - Address 3 Bit  
*/
module rom(clk,en,data_out,address);
 // Ports List
  input [2:0] address;
  input en,clk;
  output reg [7:0] data_out;
 // Memory 
  reg [7:0] memory [7:0];
  reg [3:0] i;

  always @(posedge clk)
  begin
    for(i=4'b0;i<4'b1000;i=i+1)
      begin
        memory[i] = i;
      end
  end 


  always@(posedge clk)
    begin
      if(en)
        begin
          data_out <= memory[address];
        end
      else 
        begin
          data_out <= 8'bxxxxxxxx;
        end
    end
endmodule 


//test Bench
// Test Bench of ROM 8*8
module tb;
  reg clk,en;
  reg [2:0] address;
  wire [7:0] data_out;
  integer i;
  always #5 clk = ~ clk;
  rom r1(clk,en,data_out,address);
  initial begin
    clk=1;
    $monitor($time,"Enable=%b, Address=%b, Data_out=%d",en,address,data_out);
    en=0;
    en=1;
    #10;
    address=0;
    for(i=0;i<8;i=i+1)
      begin
        address = address + 1;
        #10;
      end
  end  
  initial begin
  #90 $finish;
  end        
endmodule
