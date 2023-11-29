//------------------4 BIT VEDIC MULTIPLIER-------------------------------//
// Half Adder 
module ha(input a,b,output sum,carry);
  assign sum = a ^ b;
  assign carry = a & b;
endmodule 

// Full Adder 
module fa(input a,b,cin,output sum,carry);
  assign sum = a ^ b ^ cin;
  assign carry = (a & b) | (b & cin) | (cin & a);
endmodule 

// 4 Bit Ripple Carry Adder 
module rca4(a,b,cin,s,cout);
  input [3:0] a,b;
  input cin;
  output [3:0] s;
  output cout;
  wire c1,c2,c3;
  
  fa f1(a[0],b[0],cin,s[0],c1);
  fa f2(a[1],b[1],c1,s[1],c2);
  fa f3(a[2],b[2],c2,s[2],c3);
  fa f4(a[3],b[3],c3,s[3],cout);
endmodule 

// 8 Bit Ripple Carry Adder 
module rca8(a,b,cin,s,cout);
  input [7:0] a,b;
  input cin;
  output [7:0] s;
  output cout;
  wire c1;

  rca4 a1(a[3:0],b[3:0],cin,s[3:0],c1);
  rca4 a2(a[7:4],b[3:0],c1,s[3:0],cout);
  
endmodule 

///////////////////////////////////////////////////////////////////////
//---------------------------MAIN MODULE ------------- -------------//
/////////////////////////////////////////////////////////////////////

//2 Bit Vedic Multiplier 
module vm2bit(a,b,z);
  input [1:0] a,b;
  output [3:0] z;
  reg p[1:0][1:0];
  wire [1:0] s,c;
  integer i,j;
  always @(a,b) begin
    for(i=0;i<2;i=i+1) 
      for(j=0;j<2;j=j+1)
        p[j][i] = a[j] & b[i];
  end 

  ha h1(p[0][1],p[1][0],s[0],c[0]);
  ha h2(c[0],p[1][1],s[1],c[1]);

  assign z[0]=p[0][0];
  assign z[1]=s[0];
  assign z[2]=s[1];
  assign z[3]=c[1];
  
endmodule 

//4 bit vedic multipier 
module vm4bit(a,b,z);
  input [3:0] a,b;
  output [7:0] z;
  wire [15:0] s;
  wire c1,c2,c3;
  wire [3:0] s1;
  wire [3:0]sp;

  // Using 2 Bit Vedic Multiplier 
  vm2bit v1(a[1:0],b[1:0],s[3:0]);
  vm2bit v2(a[1:0],b[3:2],s[7:4]);
  vm2bit v3(a[3:2],b[1:0],s[11:8]);
  vm2bit v4(a[3:2],b[3:2],s[15:12]);

  // Using Ripple Carry Adder
  rca4 a1(s[11:8],s[7:4],1'b0,s1[3:0],c1);
  rca4 a2(s1[3:0],{1'b0,1'b0,s[3],s[2]},1'b0,sp[3:0],c2);
  rca4 a3(s[15:12],{c1,1'b0,sp[3:2]},1'b0,z[7:4],c3);
  
  assign z[1:0]=s[1:0];
  assign z[3:2]=sp[1:0];
  
endmodule




//-------------------------------Test Bench------------------------------------//
module tb;
  reg [3:0] a,b;
  wire [7:0] z;
  vm4bit v1(a,b,z);
  initial begin
    $monitor($time,"a=%d,b=%d,z=%d",a,b,z);
    #5;
    a=4'd2; b=4'd3;
    #5;
    a=4'd3; b=4'd3;
    #5;
    a=4'd8; b=4'd3;
    #5;
    a=4'd8; b=4'd10;
    #5;
    a=4'd14; b=4'd14;
  end 
endmodule
