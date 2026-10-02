`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2026 11:33:17 PM
// Design Name: 
// Module Name: test
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


module test;
    reg  [13:0] SW;
    wire [10:0] LED;
 
    car_system uut(.SW(SW), .LED(LED));
 
    initial begin
 
        // Scenario 1: All systems good, ready to start (SRV=0)
        SW = 14'b11111111101110;
        #10;
        $display("Scenario 1: All-good / ready to start");
        $display("  SW   = %b", SW);
        $display("  LED  = %b  (START_PERMIT=%b CHIME=%b PRI1=%b PRI2=%b)",
                   LED, LED[10], LED[9], LED[7], LED[8]);
        if (LED[10] !== 1'b1 || LED[9] !== 1'b0)
            $display("  ** FAIL: expected START_PERMIT=1, CHIME=0 **");
        else
            $display("  PASS");
        $display("");
        // Scenario 2: Driver seatbelt unfastened, key in (SRV=0)
        SW = 14'b01111111101110;
        #10;
        $display("Scenario 2: Driver seatbelt unfastened, key in");
        $display("  SW   = %b", SW);
        $display("  LED  = %b  (START_PERMIT=%b CHIME=%b SEAT_WARN=%b PRI2=%b)",
                   LED, LED[10], LED[9], LED[6], LED[8]);
        if (LED[6] !== 1'b1 || LED[9] !== 1'b1 || LED[10] !== 1'b0)
            $display("  ** FAIL: expected SEAT_WARN=1, CHIME=1, START_PERMIT=0 **");
        else
            $display("  PASS");
        $display("");
        // Scenario 3: Service mode override. SB=0, BRK=0, PARK=0, SRV=1
        SW = 14'b01100111101111;
        #10;
        $display("Scenario 3: Service mode override (SRV=1)");
        $display("  SW   = %b", SW);
        $display("  LED  = %b  (START_PERMIT=%b)", LED, LED[10]);
        if (LED[10] !== 1'b1)
            $display("  ** FAIL: expected START_PERMIT=1 despite brake/park/seatbelt being 0 **");
        else
            $display("  PASS");
 
        $finish;
    end
endmodule
