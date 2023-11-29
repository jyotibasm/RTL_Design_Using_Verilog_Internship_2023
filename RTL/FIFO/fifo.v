/* -------------------------SYNCHOURNOUS FIFO------------------------*/
// SROM 8*8
module fifo(
 input [7:0] data_in, 					// Input Data Bus 
 input wr_en,rd_en,reset,write_clk,read_clk,	// Interupt Signalas
 output reg [7:0] data_out,				// Output Data Bus
 output reg empty_flag,full_flag 
);

 parameter n=3; /* width - 2^^n */
 parameter m=7; /* depth - m */

 //Memory Array
 reg [7:0] memory [7:0];

 //Pointer 
 reg [2:0]write_pointer,read_pointer;

 /* Write Logic */
 always @(posedge write_clk)
 begin

	if(wr_en && empty_flag)
		begin
			memory [write_pointer] <= data_in;
			write_pointer = write_pointer + 1;
		end 
	
 end

 /* Read Logic */
 always @(posedge read_clk)
 begin
 	if(rd_en && full_flag)
 	begin
		data_out <= memory [read_pointer];
                read_pointer = read_pointer + 1;
 	end  
 end 

 // Flags Control Logic
 always @ (posedge write_clk or posedge read_clk)
 begin
 	if(reset) 
   	begin
 		write_pointer = 3'b000;
		read_pointer = 3'b000;		
 	end 
	else 
	begin
		if(write_pointer - read_pointer == 0 || read_pointer == 3'b111 || write_pointer != 3'b111)
		begin
			empty_flag = 1;
                        full_flag = 0;
		end
		else if(write_pointer == 3'b111 || empty_flag != 1) 
		begin
			full_flag = 1;
                        empty_flag = 0;
		end 
	end 
 end 
endmodule 




//-----------------------Test Bench---------------------------//
module tb;
 reg rd_en,wr_en,reset,write_clk,read_clk;
 reg [7:0] data_in;
 wire [7:0] data_out;
 wire empty_flag,full_flag;
 always #1 write_clk = ~ write_clk;
 always #2  read_clk = ~ read_clk; 
 fifo f1(data_in,wr_en,rd_en,reset,write_clk,read_clk,data_out,empty_flag,full_flag);
 initial
 begin
 write_clk = 1;
 read_clk = 1;
 $monitor($time,"rst=%b,rw_en=%b,wr_en=%b,ef=%b,ff=%b,data_in=%d,data_out=%d",
  reset,
  rd_en,
  wr_en,
  empty_flag,
  full_flag, 
  data_in,
  data_out
 );

  reset=1;
  #2 reset=0; rd_en=0;  wr_en=1; data_in = 8'd15;
  #2 data_in = 8'd14;
  #2 data_in = 8'd13;
  #2 data_in = 8'd12;
  #2 data_in = 8'd11;
  #2 data_in = 8'd10;
  #2 data_in = 8'd9;
  #2 data_in = 8'd8;

  #2  wr_en=0; rd_en=1;
 end 
 initial 
  #150 $finish;
 begin
 end 
endmodule



