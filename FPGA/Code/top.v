`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2020 10:47:42
// Design Name: 
// Module Name: top
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


module top(
    input reset,
    input CLK100MHZ,
    input [7:0] pwm_in,
    output [7:0]SegmentDrivers, //J17, J18, T9, J14
    output [7:0]SevenSegment // T10, R10, K16, K13, P15, T11, L18, H15
    );
    
    //reg CLK100MHZ;
    reg [7:0] p; //Address of pattern in pattern bram
    reg [7:0] pl; //length of the pattern to be searched for
    reg [7:0] b; //the address block of memory to search
    reg [7:0] bl;// length of the block address to be searched
    reg activate; // if activate clock to activate the PSA and tell it to continue searching from last address
   // reg reset;//set b and clock reset to tell the PSA to start searching from address b
    wire done;//set to high when search ids done
    wire [7:0] found;// returns where the pattern being searched for is found
    
    //display 
    reg [3:0]thousands = 4'd0;
	reg [3:0]hundreds = 4'd0;
	reg [3:0]tens = 4'd0;
	reg [3:0]units = 4'd0;
	wire reset_Up;
    
    
    
    initial begin
        p = 9;
        pl = 7;
        b = 0;
        bl = 206;
        activate = 0;
        //Reset
        //reset = 0; #5
        //reset = 0; 
        //reset = 0; #5
        //Begin search after reset
        activate = 1;
        
        thousands <= 0;
        hundreds <= 0;
        tens <= 0;
        units <= 0; 
        
    end
    
    ///instantiate the search
    search test(
    .CLK100MHZ(CLK100MHZ),
    .p(p),
    .pl(pl),
    .b(b),
    .bl(bl),
    .activate(activate),
    .reset(reset_Up),
    .done(done),
    .found(found));
    
    //instantiate seven segment
    SS_Driver SS_Driver1(
		CLK100MHZ, reset_Up,
		thousands, hundreds, tens, units, // Use temporary test values before adding hours2, hours1, mins2, mins1
		pwm_in,
		SegmentDrivers, SevenSegment
	);
    
    Debounce debouncer1(CLK100MHZ,reset,reset_Up);//interrrupt and debounce for minutes

    
//    SS_Driver SS_Driver1(
//		CLK100MHZ, reset_Up,
//		1, 2, 3, 4, // Use temporary test values before adding hours2, hours1, mins2, mins1
//		pwm_in,
//		SegmentDrivers, SevenSegment
//	);
    
    always@(CLK100MHZ, found)begin
       $display("Searching for a match for 78\,77\,77"); 
        thousands <= found - ((found%1000)/1000);
        hundreds <= ((found- thousands*1000))-(((found- thousands*1000)%100)/100);
        tens <= (found- thousands*1000-hundreds*100) - ((found- thousands*1000-hundreds*100)%10);
        units <= (found- thousands*1000-hundreds*100 - tens*10); 
        
       if ( !(found < 0))begin
              
       
            $display("A match was found at address \t%d after %d ns", found, $time);
        end
  end    
endmodule

