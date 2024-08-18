`timescale 1ns/1ns
`include "multiplier.v"
module multiplier_tb;
    parameter n_bits = 5;
    reg [n_bits-1:0]a_in;
    reg [n_bits-1:0]b_in;
    reg clock;
    reg start;
    reg reset;
    wire [(n_bits*2)-1:0]out;
    wire finish;
    wire [(((n_bits*2)/3)+1)*4-1:0]bcd;

    multiplier uut(
        .out(out),
        .a_in(a_in),
        .b_in(b_in),
        .clock(clock),
        .start(start),
        .reset(reset),
        .finish(finish),
        .bcd(bcd));
    defparam uut.N = n_bits;
    initial 
    begin
      $dumpfile("multiplier.vcd");
      $dumpvars(0,multiplier_tb);  
      forever #50 clock = ~clock;    
    end

    initial 
    begin
      a_in = 0;
      b_in = 0;
      clock = 0;
      start = 0;
      reset = 0;
      #100;
      a_in = 'd26;
      b_in = 'd30;
      start = 0;
      #200 start = 1;
      #1000; 
      a_in = 'd13; b_in = 'd13;
      start = 0;
      #200 start = 1; 
      #1000;   
    end

    initial begin
        #2500 $finish;
    end    
endmodule