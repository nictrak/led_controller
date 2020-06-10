`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2020 11:48:56 AM
// Design Name: 
// Module Name: Controller
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


module Controller(
    output reg serial,
    output reg sclk,
    output reg[3:0] lat,
    output reg gsclk,
    output reg[3:0] state,
    input wire[31:0] instruction,
    input wire clk
    );
    //op_code enum
    parameter BUFFER_DATA  = 1;
    parameter SEND_SIGNAL = 2;
    parameter SEND_GS     = 3;
    parameter SEND_LATCH  = 4;
    parameter DUMP_SIGNAL = 5;
    parameter FLASH_WITH_TRG = 6;
    parameter FLASH_WITH_TRG_2 = 7;
    parameter SET_GS_PSC = 8;
    parameter QUERY_STATUS = 9;
    parameter SET_CONTINUOUS = 10;
    parameter STOP_CONTINUOUS = 11;
    parameter WRITE_SPI = 12;
    parameter SPI_REINIT = 13;
    parameter MOVE_SPI = 14;
    parameter FLASH_WITH_TRG_3 = 15;
    parameter FLASH_WITH_TRG_4 = 16;
    parameter SAVE_PATTERN = 17;
    parameter LOAD_PATTERN = 18;
    parameter SET_CONTINUOUS_AUTO_INC = 19;
    parameter SET_CONTINUOUS_SKIP = 20;
    
    //state enum
    parameter READY = 0;
    parameter WAIT_LAT = 1;
    
    wire[7:0] op_code;
    wire[15:0] index;
    assign op_code = instruction[31:24];
    assign index = instruction[23:8];
    
    wire time_out;
    reg[3:0] tick_lat = 3;
    reg start_wait_lat;
    Wait waiter(
        .out(time_out),
        .start(start_wait_lat),
        .tick(tick_lat),
        .clk(clk)  
    );
    
    initial begin
        state <= 0;
        state <= 0;
        serial <= 0;
        sclk <= 0;
        lat <= 0;
        gsclk <= 0;
        start_wait_lat = 0;
    end
    
    always @(posedge clk) begin
        case(state)
            READY: begin
                    case(op_code)
                        SEND_LATCH: begin
                            start_wait_lat <= 1;
                            lat[index] <= 1;
                            state <= WAIT_LAT;    
                        end
                        default: ;
                    endcase
            end
            WAIT_LAT: begin
                start_wait_lat <= 0;
                if(time_out === 1) begin
                    state <= READY;
                    lat[index] <= 0;
                end else lat[index] <= 1;
            end
            default: ;
        endcase
    end
endmodule
