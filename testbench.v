`include "main.v"
module fft_tb;
  reg [7:0][7:0] inp_real;
  reg [7:0][7:0] inp_imag;
  wire  [7:0][7:0] out_real;
  wire [7:0][7:0] out_imag;
  // wire r;
  // wire i;
  
  fft_8 DUT(.inp_real(inp_real),.inp_imag(inp_imag),.out_real(out_real),.out_imag(out_imag));
  
  initial begin
    #5 inp_real[0] = 8'b00000001;inp_imag[0]=8'b00000000;
    #5 inp_real[1] = 8'b00000010;inp_imag[1]=8'b00000000;
    #5 inp_real[2] = 8'b00000011;inp_imag[2]=8'b00000000;
    #5 inp_real[3] = 8'b00000100;inp_imag[3]=8'b00000000;
    #5 inp_real[4] = 8'b00000101;inp_imag[4]=8'b00000000;
    #5 inp_real[5] = 8'b00000110;inp_imag[5]=8'b00000000;
    #5 inp_real[6] = 8'b00000111;inp_imag[6]=8'b00000000;
    #5 inp_real[7] = 8'b00001000;inp_imag[7]=8'b00000000;
    #5;
    $display("--------------");
    $display("INPUT SEQUENCE ");
    $display("--------------");
    $display("%0d + j%0d",inp_real[0], inp_imag[0]);
    $display("%0d + j%0d",inp_real[1], inp_imag[1]);
    $display("%0d + j%0d",inp_real[2], inp_imag[2]);
    $display("%0d + j%0d",inp_real[3], inp_imag[3]);
    $display("%0d + j%0d",inp_real[4], inp_imag[4]);
    $display("%0d + j%0d",inp_real[5], inp_imag[5]);
    $display("%0d + j%0d",inp_real[6], inp_imag[6]);
    $display("%0d + j%0d",inp_real[7], inp_imag[7]);
    $display("------------");
    $display("------------");
    $display("OUTPUT ");
    $display("------------");
    $display("%0d + j%0d",out_real[0], out_imag[0]);
    $display("%0d + j%0d",out_real[1], out_imag[1]);
    $display("%0d + j%0d",out_real[2], out_imag[2]);
    $display("%0d + j%0d",out_real[3], out_imag[3]);
    $display("%0d + j%0d",out_real[4], out_imag[4]);
    $display("%0d + j%0d",out_real[5], out_imag[5]);
    $display("%0d + j%0d",out_real[6], out_imag[6]);
    $display("%0d + j%0d",out_real[7], out_imag[7]);
    $display("------------");
    
    $finish(1);
  end
  
  initial begin
    $dumpfile("fft.vcd");
    $dumpvars(2,fft_tb);
  end
endmodule