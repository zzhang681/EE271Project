// Under developing...
module oneToFour(in, out3, out2, out1, out0);
	input [15:0] in;
	output [3:0] out3, out2, out1, out0;

	assign out3 = in[15:12];
	assign out2 = in[11:8];
	assign out1 = in[7:4];
	assign out0 = in[3:0];
	
endmodule