`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2020 11:11:55 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb(
    );
    reg reset;
    reg CLK100MHZ;
    reg [7:0] pwm_in;
    wire [7:0]SegmentDrivers; //J17, J18, T9, J14
    wire [7:0]SevenSegment; // T10, R10, K16, K13, P15, T11, L18, H15
    wire [15:0] LED;
    
    top top_test(
    .reset(reset),
    .CLK100MHZ(CLK100MHZ),
    .pwm_in(pwm_in),
    .SegmentDrivers(SegmentDrivers), //J17, J18, T9, J14
    .SevenSegment(SevenSegment), // T10, R10, K16, K13, P15, T11, L18, H15
    .LED(LED)
    );
    initial begin
        CLK100MHZ = 0;
        reset = 0; #5
        reset = 1; #5
        reset = 0; 
    end
    
    always begin
        #1  CLK100MHZ =~ CLK100MHZ;
        
    end
    
endmodule
