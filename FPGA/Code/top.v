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
    input CLK100MHZ
    );
     // Memory IO
    reg ena = 1;
    reg wea = 0;
    reg [7:0] addra=0; //The addresses will range from 0 to 250 assuming the data_250.coe is used
    reg [7:0] dina=0; //We're not putting data in, so we can leave this unassigned
    wire [7:0] douta; //This is a single byte from memory from a particular adress (addra)
    
    
    // Instantiate block memory 
    // Copy from the instantiation template and change signal names to the ones under "MemoryIO"
    blk_mem_gen_0 bram (
      CLK100MHZ,    // input wire clka
      ena,      // input wire ena
      wea,      // input wire [0 : 0] wea
      addra,  // input wire [7 : 0] addra
      dina,    // input wire [7 : 0] dina
      douta  // output wire [7 : 0] douta
    );
    
    
endmodule
