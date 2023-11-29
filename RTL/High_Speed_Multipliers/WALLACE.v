// Wallace tree Multiplier 
// Half Addder
module ha(input a,b,output sum,carry);
	assign sum = a ^ b;
	assign carry = a & b;
endmodule 

// Full Adder 
module fa(input a,b,cin,output sum,carry);
	assign sum = a ^ b ^ cin;
	assign carry = (a & b) | (b & cin) | (cin & a);
endmodule 

module wm4b(prod,a,b);
	input [3:0] a,b;
	output [7:0] prod;
	wire [11:0] s,c;
	integer i,j;
	reg p [3:0][3:0];
always@(a,b) begin
	for(i=0;i<4;i=i+1) begin 
	 for (j=0;j<4;j=j+1) begin
	         p[j][i] <= a[j] & b[i]; end
	end
end
        //First Stage
	ha h1(p[0][1],p[1][0],s[0],c[0]);
	fa f1(p[0][2],p[1][1],p[2][0],s[1],c[1]);
	fa f2(p[0][3],p[1][2],p[2][1],s[2],c[2]);
	ha h2(p[1][3],p[2][2],s[3],c[3]);

	// Second Stage 
	ha h3(s[1],c[0],s[4],c[4]);
	fa f3(s[2],c[1],p[3][0],s[5],c[5]);
	fa f4(s[3],c[2],p[3][1],s[6],c[6]);
	fa f5(p[2][3],c[3],p[3][2],s[7],c[7]);
	
	// Third Stage 
	ha h4(s[5],c[4],s[8],c[8]);
        fa h5(s[6],c[5],c[8],s[9],c[9]);
        fa h6(s[7],c[6],c[9],s[10],c[10]);
	fa f7(p[3][3],c[7],c[10],s[11],c[11]);
      
	// Product 
	assign prod[0]=p[0][0];
	assign prod[1]=s[0];
	assign prod[2]=s[4];
	assign prod[3]=s[8];
	assign prod[4]=s[9];
	assign prod[5]=s[10];
	assign prod[6]=s[11];
	assign prod[7]=c[11];

endmodule 

//8 Bit wallace multiplie

// Test Bench 
module tb;
 reg [3:0] a,b;
 wire [7:0] prod;
 wm4b w1(prod,a,b);
initial begin
 $monitor($time,"a=%d, b=%d, product=%d",a,b,prod);
 #5; 
 a=4'd5; b=4'd2;
 #5; 
 a=4'd10; b=4'd10;
 #5; 
 a=4'd15; b=4'd2;
 #5; 
 a=4'd10; b=4'd13;
 #5; 
 a=4'd55; b=4'd2;
 #5; 
 a=4'd10; b=4'd3;
 #5; 
 a=4'd14; b=4'd14;
end
endmodule 

