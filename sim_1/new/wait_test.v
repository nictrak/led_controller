`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2020 05:38:09 PM
// Design Name: 
// Module Name: wait_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wait_test(

    );
    wire out;
    reg start;
    reg [3:0] tick;
    reg clk;
    Wait w(
    .out(out),
    .start(start),
    .tick(tick),
    .clk(clk));
    
    always #5 clk = ~clk;
    
    initial begin
    #0
    clk = 0;
    tick = 3;
    start = 0;
    #7
    start = 1;
    #5 
    start = 0;
    #100
    tick = 10;
    #1
    start = 1;
    #5 
    start = 0;
    #1000 $finish;
    end
    
endmodule
