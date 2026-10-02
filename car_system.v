`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2026 08:09:25 PM
// Design Name: 
// Module Name: car_system
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

module car_system(input  [13:0] SW, output [10:0] LED);
    wire SB=SW[13], DOOR=SW[12], KEY=SW[11], BRK=SW[10], PARK=SW[9], HOOD=SW[8];
    wire BAT_OK=SW[7], AIB_OK=SW[6], TMP_OK=SW[5], PASS_OCC=SW[4], SB_P=SW[3];
    wire TRUNK=SW[2], PBRK=SW[1], SRV=SW[0];

    wire SEAT_WARN = ~SB | (PASS_OCC & ~SB_P);
    wire DOOR_WARN = ~DOOR;
    wire HOOD_WARN = ~HOOD;
    wire TRUNK_WARN = ~TRUNK;
    wire BAT_WARN = ~BAT_OK;
    wire AIRBAG_WARN = ~AIB_OK;
    wire TEMP_WARN = ~TMP_OK;

    wire CHIME = KEY & (SEAT_WARN|DOOR_WARN|HOOD_WARN|TRUNK_WARN|BAT_WARN|AIRBAG_WARN|TEMP_WARN);
    wire WARN_PRI1 = AIRBAG_WARN | BAT_WARN | TEMP_WARN;
    wire WARN_PRI2 = ~WARN_PRI1 & (SEAT_WARN|DOOR_WARN|HOOD_WARN|TRUNK_WARN);
    wire START_PERMIT = SRV | (KEY & BRK & PARK & SB);

    assign LED[10]= START_PERMIT; 
    assign LED[9]= CHIME; 
    assign LED[8]= WARN_PRI2; 
    assign LED[7]= WARN_PRI1;
    assign LED[6]= SEAT_WARN; 
    assign LED[5]= DOOR_WARN; 
    assign LED[4]= HOOD_WARN; 
    assign LED[3]= TRUNK_WARN;
    assign LED[2]= BAT_WARN; 
    assign LED[1]= AIRBAG_WARN; 
    assign LED[0]= TEMP_WARN; 
endmodule
