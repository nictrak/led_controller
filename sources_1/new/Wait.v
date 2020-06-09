`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2020 03:19:29 PM
// Design Name: 
// Module Name: Wait
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


module Wait(
    output reg out,
    input wire start,
    input wire[3:0] tick,
    input wire clk
    );
    
    wire sync;
    reg[1:0] state;
    reg[3:0] counter;
    
    initial begin
        state <= 0;
        counter <= 0;
        out <= 0;
    end
    
    assign sync = (state === 0)? start : clk;
    
    always @(posedge sync) begin
        case(state)
            2'b00: state <= state + 1;
            2'b01: if(tick - 1 > counter) counter <= counter + 1;
                   else begin
                        state <= state + 1;
                        out <= 1;
                        counter <= 0;
                   end  
            2'b10: begin
                        out <= 0;
                        state <= 2'b00;
                   end
        endcase
    end
    
    
    
    
endmodule
