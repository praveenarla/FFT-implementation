
module fft_8(input  [7:0][7:0] inp_real,
             input  [7:0][7:0] inp_imag,
             output reg [7:0][7:0] out_real,
             output reg [7:0][7:0] out_imag
            );

  function  [15:0]out_r3  (input reg [7:0] real_a,
                input reg [7:0] imag_a,
                input reg [7:0] real_b,
                input reg [7:0] imag_b);
                
      out_r3 = ((real_a*real_b) - (imag_a*imag_b))*a;
  endfunction
function  [15:0]out_r4  (input reg [7:0] real_a,
                input reg [7:0] imag_a,
                input reg [7:0] real_b,
                input reg [7:0] imag_b);
                
      out_r4 = ((real_a*real_b) - (imag_a*imag_b));
endfunction

 function  [15:0]out_i3  (input reg [7:0] real_a,
                input reg [7:0] imag_a,
                input reg [7:0] real_b,
                input reg [7:0] imag_b);
                
     out_i3 = ((real_a*imag_b)) + ((real_b*imag_a))*a;

 endfunction

  function  [15:0]out_i4  (input reg [7:0] real_a,
                input reg [7:0] imag_a,
                input reg [7:0] real_b,
                input reg [7:0] imag_b);
                
     out_i4 = ((real_a*imag_b) + (real_b*imag_a));

 endfunction

   real a;
   reg [7:0] twiddle_real[0:3];
   reg [7:0] twiddle_imag[0:3];
   

  initial begin
    a = 0.7071;
    twiddle_real[0]=8'b00000001;
    twiddle_real[1]=8'b00000001;
    twiddle_real[2]=8'b00000000;
    twiddle_real[3]=8'b11111111;
    twiddle_imag[0]=8'b00000000;
    twiddle_imag[1]=8'b11111111;
    twiddle_imag[2]=8'b11111111;
    twiddle_imag[3]=8'b11111111;
   end  
  reg [7:0][7:0] X_real ;
  reg [7:0][7:0] X_imag;
  reg [7:0][7:0] X_real_prev;
  reg [7:0][7:0] X_imag_prev;
  
  always@(*) begin
        
    	// STAGE 1 : 2 Point FFT
    
        X_real[0] = inp_real[0] + inp_real[4];
        X_real[1] = inp_real[0] - inp_real[4];
        X_real[2] = inp_real[2] + inp_real[6];
        X_real[3] = inp_real[2] - inp_real[6];
        X_real[4] = inp_real[1] + inp_real[5];
        X_real[5] = inp_real[1] - inp_real[5];
        X_real[6] = inp_real[3] + inp_real[7];
        X_real[7] = inp_real[3] - inp_real[7];
    
        X_imag[0] = inp_imag[0] + inp_imag[4];
        X_imag[1] = inp_imag[0] - inp_imag[4];
        X_imag[2] = inp_imag[2] + inp_imag[6];
        X_imag[3] = inp_imag[2] - inp_imag[6];
        X_imag[4] = inp_imag[1] + inp_imag[5];
        X_imag[5] = inp_imag[1] - inp_imag[5];
        X_imag[6] = inp_imag[3] + inp_imag[7];
        X_imag[7] = inp_imag[3] - inp_imag[7];
        
        X_real_prev = X_real;
        X_imag_prev = X_imag;

    
    	// STAGE 2 : 4 Point FFT
        
    	  X_real_prev[3] = out_r4 (X_real[3], X_imag[3],twiddle_real[2],twiddle_imag[2]);
        X_imag_prev[3] = out_i4 (X_real[3], X_imag[3],twiddle_real[2],twiddle_imag[2]);
        X_real_prev[7] = out_r4(X_real[7], X_imag[7],twiddle_real[2],twiddle_imag[2]);
        X_imag_prev[7] = out_i4(X_real[7], X_imag[7],twiddle_real[2],twiddle_imag[2]);

       	X_real[0] = X_real_prev[0] + X_real_prev[2];
        X_real[1] = X_real_prev[1] + X_real_prev[3];
        X_real[2] = X_real_prev[0] - X_real_prev[2];
        X_real[3] = X_real_prev[1] - X_real_prev[3];
        X_real[4] = X_real_prev[4] + X_real_prev[6];
        X_real[5] = X_real_prev[5] + X_real_prev[7];
        X_real[6] = X_real_prev[4] - X_real_prev[6];
        X_real[7] = X_real_prev[5] - X_real_prev[7];
        
        X_imag[0] = X_imag_prev[0] + X_imag_prev[2];
        X_imag[1] = X_imag_prev[1] + X_imag_prev[3];
        X_imag[2] = X_imag_prev[0] - X_imag_prev[2];
        X_imag[3] = X_imag_prev[1] - X_imag_prev[3];
        X_imag[4] = X_imag_prev[4] + X_imag_prev[6];
        X_imag[5] = X_imag_prev[5] + X_imag_prev[7];
        X_imag[6] = X_imag_prev[4] - X_imag_prev[6];
        X_imag[7] = X_imag_prev[5] - X_imag_prev[7];
        
        X_real_prev = X_real;
        X_imag_prev = X_imag;
    
    
    	// Stage 3: 16 Point FFT
    
        X_real_prev[5] = out_r3(X_real[5], X_imag[5],twiddle_real[1],twiddle_imag[1]);
        X_imag_prev[5] = out_i3(X_real[5], X_imag[5],twiddle_real[1],twiddle_imag[1]);
        X_real_prev[6] = out_r4(X_real[6], X_imag[6],twiddle_real[2],twiddle_imag[2]);
        X_imag_prev[6] = out_i4(X_real[6], X_imag[6],twiddle_real[2],twiddle_imag[2]);
        X_real_prev[7] = out_r3(X_real[7], X_imag[7],twiddle_real[3],twiddle_imag[3]);
        X_imag_prev[7] = out_i3(X_real[7], X_imag[7],twiddle_real[3],twiddle_imag[3]);


        //multiply(X_real[6], X_imag[6],twiddle_real[2],twiddle_imag[2],X_real_prev[6],X_imag_prev[6]);
        //multiply(X_real[7], X_imag[7],twiddle_real[3],twiddle_imag[3],X_real_prev[7],X_imag_prev[7]);
    
        X_real[0] = X_real_prev[0] + X_real_prev[4];
        X_real[1] = X_real_prev[1] + X_real_prev[5];
        X_real[2] = X_real_prev[2] + X_real_prev[6];
        X_real[3] = X_real_prev[3] + X_real_prev[7];
        X_real[4] = X_real_prev[0] - X_real_prev[4];
        X_real[5] = X_real_prev[1] - X_real_prev[5];
        X_real[6] = X_real_prev[2] - X_real_prev[6];
        X_real[7] = X_real_prev[3] - X_real_prev[7];
        
        X_imag[0] = X_imag_prev[0] + X_imag_prev[4];
        X_imag[1] = X_imag_prev[1] + X_imag_prev[5];
        X_imag[2] = X_imag_prev[2] + X_imag_prev[6];
        X_imag[3] = X_imag_prev[3] + X_imag_prev[7];
        X_imag[4] = X_imag_prev[0] - X_imag_prev[4];
        X_imag[5] = X_imag_prev[1] - X_imag_prev[5];
        X_imag[6] = X_imag_prev[2] - X_imag_prev[6];
        X_imag[7] = X_imag_prev[3] - X_imag_prev[7];
      
        out_real = X_real;
        out_imag = X_imag;

  end
endmodule