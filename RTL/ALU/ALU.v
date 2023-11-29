// Design, Verification & Synthesis Of 2 Bit ALU
module alu(a,b,rst,opcode,r);
 input [1:0]a,b,opcode;
 input rst;
 output [3:0] r;
 reg [3:0] r;
 always @(a,b,opcode,rst) begin
 if(!rst) begin 
 	case(opcode) 
 	2'b00: begin r = a + b; end
 	2'b01: begin r = a - b; end
 	2'b10: begin r = a & b; end
 	2'b11: begin r = a | b; end
        default r=4'b0000;
 	endcase 
 end 
 else begin  r=4'bxxxx; end
 end
endmodule  
