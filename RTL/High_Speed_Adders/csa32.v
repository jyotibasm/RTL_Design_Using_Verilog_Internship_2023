// Carry Select Adder 32-Bit
module fa(input a,b,cin,output s,cout);
	assign s = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

module mux21(input i0,i1,s,output y);
	wire y1,y2,s_not;
	not (s_not,s);
	and (y1,i0,s_not);
	and (y2,i1,s);
	or (y,y1,y2);
endmodule 

// 4bit Carry Select Adder
module csa4bit(a,b,cin,s,cout,c_0,c_1);
  input [3:0] a,b;
  input cin,c_0,c_1;
  wire [3:0] s1,s2;
  output [3:0] s;
  output cout;
  wire cout_0,cout_1;
  wire [2:0] c0,c1;
 
	// Carry Ripple Adder with 0 carry
	fa f1(a[0],b[0],c_0,s1[0],c0[0]);
	fa f2(a[1],b[1],c0[0],s1[1],c0[1]);
	fa f3(a[2],b[2],c0[1],s1[2],c0[2]);
	fa f4(a[3],b[3],c0[2],s1[3],cout_0);

	// Carry Ripple Adder with 1 carry
	fa f5(a[0],b[0],c_1,s2[0],c1[0]);
	fa f6(a[1],b[1],c1[0],s2[1],c1[1]);
	fa f7(a[2],b[2],c1[1],s2[2],c1[2]);
	fa f8(a[3],b[3],c1[2],s2[3],cout_1);

	mux21 m1(cout_0,cout_1,cin,cout);
	mux21 m2(s1[0],s2[0],cin,s[0]);
	mux21 m3(s1[1],s2[1],cin,s[1]);
	mux21 m4(s1[2],s2[2],cin,s[2]);
	mux21 m5(s1[3],s2[3],cin,s[3]);

endmodule 

// 8 bit Carry Select Adder

module csa8bit(a,b,cin,s,cout,c_0,c_1);
   input [7:0] a,b;
   input c_0,c_1;
   input cin;
   output [7:0] s;
   output cout;
   wire c;
   csa4bit c1(a[3:0],b[3:0],cin,s[3:0],c,c_0,c_1);
   csa4bit c2(a[7:4],b[7:4],c,s[7:4],cout,c_0,c_1);
endmodule 


// 16 bit Carry Select Adder 
module csa16bit(a,b,cin,s,cout,c_0,c_1);
   input [15:0] a,b;
   input c_0,c_1;
   input cin;
   output [15:0] s;
   output cout;
   wire c;
   csa8bit c1(a[7:0],b[7:0],cin,s[7:0],c,c_0,c_1);
   csa8bit c2(a[15:8],b[15:8],c,s[15:8],cout,c_0,c_1);
endmodule 


// 32 bit Carry Select Adder
module csa32bit(a,b,cin,s,cout,c_0,c_1);
   input [31:0] a,b;
   input c_0,c_1;
   input cin;
   output [31:0] s;
   output cout;
   wire c;
   csa16bit c1(a[15:0],b[15:0],cin,s[15:0],c,c_0,c_1);
   csa16bit c2(a[31:16],b[31:16],c,s  [31:16],cout,c_0,c_1);
endmodule 


//Test-Bench 
module tb;
 reg [31:0]a,b;
 reg cin=0,c_0=0,c_1=1;
 wire [31:0] s;
 wire  cout;
 csa32bit f1(a,b,cin,s,cout,c_0,c_1);
 initial begin
 $monitor($time,"a=%b,b=%b,cin=%b,s=%b,cout=%b",a,b,cin,s,cout);
 #5;
 a=32'd0; b=32'd0;
 #5;
 a=32'd5; b=32'd1;
 #5;
 a=32'd15; b=32'd15;
 end
endmodule






