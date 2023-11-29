// nmoore non ovelap
module seq_detector_0110(input clk, rst_n, x, output z);
  parameter S0 = 4'h0;
  parameter S1 = 4'h1;
  parameter S2 = 4'h2;
  parameter S3 = 4'h3;
  parameter S4=4'h4;
  reg [3:0] state, next_state;
  always @(posedge clk ) begin
    if(!rst_n) begin 
      state <= S0;
    end
    else state <= next_state;
  end
  
  always @(state or x) begin
    case(state)
      S0: begin
        next_state=x?S0:S1;
      end
       
       S1: begin
        next_state=x?S2:S1;
      end
       S2: begin
        next_state=x?S3:S1;
      end
       S3: begin
        next_state=x?S0:S4;
      end
      S4: begin
        next_state=x?S0:S0;
      end
      
      default: begin next_state = S0;

      end
    endcase
  end
  assign z=(state==S4);
  
endmodule

// Test Bench
// Code your testbench here
// or browse Examples
module TB;
  reg clk, rst_n, x;
  wire z;
  
  seq_detector_0110 d(clk, rst_n, x, z);
  initial clk = 0;   
  always #2 clk = ~clk;
    
  initial begin
    $monitor("%0t: x = %0b, z = %0b", $time, x, z);
    x = 0;
    #1 rst_n = 0;
    #2 rst_n = 1;
    
    #3 x = 1;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 0;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 0;
    #10;
    $finish;
  end
  
 
endmodule
