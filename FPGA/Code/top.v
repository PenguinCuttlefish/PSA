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
    input CLK100MHZ,
    input patternToBeSearched,
    input lengthPTBS, //length of the pattern to be searched for
    input blockToBeSearched, //the address block of memory to search
    input lengthBTBS,// length of the block address to be searched
    input activate,// it activate clock to activate the PSA and tell it to continue searching from last address
    input reset,//set b and clock reset to tell the PSA to start searching from address b
    output done,//set to high when search ids done
    output found// returns where the pattern being searched for is found
    
    );
    
    
    
     // Memory IO
    reg ena = 1;
    reg wea = 0;
    reg [7:0] addra=0; //The addresses will range from 0 to 250 assuming the data_250.coe is used
    reg [7:0] dina=0; //We're not putting data in, so we can leave this unassigned
    wire [7:0] douta; //This is a single byte from memory from a particular adress (addra)
    integer i;
    integer j;

    
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
    
     always @ (posedge CLK100MHZ) begin
        if (reset)begin
            addra = blockToBeSearched;
        end
        
         for (i = 0; i <lengthBTBS - lengthPTBS; i = i + 1) begin
            j = 0;
            
            for (j = 0; j < lengthPTBS; j = j + 1) begin
                
            end
            
         end
        
     end

    
    
endmodule
