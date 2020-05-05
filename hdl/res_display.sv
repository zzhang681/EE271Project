module res_display(in1, in2, out3, out2, out1, out0);
  input[7:0] in1, in2;
  output[3:0] out3, out2, out1, out0;
  wire [7:0] val1, val2, val3;
  
  

  assign out0 = in1 % 10;
  assign val1 = in1 / 10;
  
  assign out1 = val1 % 10;
  assign val2 = val1 / 10;
  
  assign out2 = val2 % 10;
  assign val3 = val2 / 10;
  
  assign out3 = val3 % 10;
  
  
  
  
endmodule