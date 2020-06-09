`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2020 03:05:25 PM
// Design Name: 
// Module Name: controller_test
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


module controller_test(

    );
    reg[7:0] instruction;
    reg clk;
    wire[3:0] state;
    Controller con(
        .serial(serial),
        .sclk(sclk),
        .lat(lat),
        .gsclk(gsclk),
        .state(state),
        .instruction(instruction),
        .clk(clk)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        #0
        clk <= 0;
        instruction <= 0;
        #24
        instruction <= 8'b00100_000;
        #5
        instruction <= 0;
        #1000 $finish;
    end
endmodule
