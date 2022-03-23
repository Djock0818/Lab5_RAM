module ram256x32_tb();
	reg [63:0] in;
	reg [63:0] Address;
	wire [7:0] RAMaddress;
	wire [63:0] out;
	reg clock;
	reg RAMwrite;
	
	ram256x32 dut(RAMaddress, clock, in, RAMwrite, out);
	
	assign RAMaddress = Address[7:0];
	
	initial begin 
		clock <= 1'b1;
		in <= 64'b0;
		Address <= 64'b0;
		RAMwrite <= 1'b1;
		#5120 $stop;
	end
	
	always #5 clock <= ~clock;
	
	always @(negedge clock) begin
		in <= {$random, $random};
		#2;
		Address <= Address+64'b1;
		#5;
	end
	
	always #2560 RAMwrite <= 1'b0;
	
	wire [63:0] mem1, mem2, mem3;
	assign mem1 = dut.mem[0];
	assign mem2 = dut.mem[1];
	assign mem3 = dut.mem[2];
endmodule 
