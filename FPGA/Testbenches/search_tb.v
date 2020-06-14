`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Vicky Feng
// 
// Create Date: 10.06.2020 19:34:24
// Design Name: 
// Module Name: search_tb
// Project Name: PSA
// Target Devices: nexys-a7
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


module search_tb(
    );
    reg CLK100MHZ;
    reg [7:0] p; //Address of pattern in pattern bram
    reg [7:0] pl; //length of the pattern to be searched for
    reg [7:0] b; //the address block of memory to search
    reg [7:0] bl;// length of the block address to be searched
    reg activate; // if activate clock to activate the PSA and tell it to continue searching from last address
    reg reset;//set b and clock reset to tell the PSA to start searching from address b
    wire done;//set to high when search ids done
    wire [7:0] found;// returns where the pattern being searched for is found
    
    search test(
    .CLK100MHZ(CLK100MHZ),
    .p(p),
    .pl(pl),
    .b(b),
    .bl(bl),
    .activate(activate),
    .reset(reset),
    .done(done),
    .found(found));
    
    initial begin
        CLK100MHZ = 0;
        p = 0;
        pl = 2;
        b = 0;
        bl = 20;
        activate = 0;
        //Reset
        reset = 0; #5
        reset = 1; #5
        reset = 0; #5
        //Begin search after reset
        activate = 1;
    end
    
    always begin
        #1  CLK100MHZ =~ CLK100MHZ;
    end
    
    always@(reset,activate,done,test.pcount,test.bcount,test.douta,test.pattern_byte,test.state)begin
        $display("reset,activate,found,done,pattern,pcount,addra_p,douta,bcount,addra,state");
        $display("%d,\t%d,\t%d,\t%d,%h,\t%d,\t%d,\t%h,\t%d,\t%d,\t%b", reset,activate,found,done,test.pattern_byte,test.pcount,test.addra_p,test.douta,test.bcount,test.addra,test.state);
    end
endmodule
