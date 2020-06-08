`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2020 21:50:10
// Design Name: 
// Module Name: search
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


module search(
    input CLK100MHZ,
    input [7:0]  patternToBeSearched,
    input [7:0] lengthPTBS, //length of the pattern to be searched for
    input [7:0] blockToBeSearched, //the address block of memory to search
    input [7:0] lengthBTBS,// length of the block address to be searched
    input  activate,// it activate clock to activate the PSA and tell it to continue searching from last address
    input reset,//set b and clock reset to tell the PSA to start searching from address b
    output reg done,//set to high when search ids done
    output reg [7:0] found// returns where the pattern being searched for is found
    
    );
    
    //create the array of the pattern
    reg [7:0] pattern [0:lengthPTBS-1];
    //reg [7:0] pattern [0:100];
     // Memory IO
    reg ena = 1;
    reg wea = 0;
    reg [7:0] addra=0; //The addresses will range from 0 to 250 assuming the data_250.coe is used
    reg [7:0] dina=0; //We're not putting data in, so we can leave this unassigned
    wire [7:0] douta; //This is a single byte from memory from a particular adress (addra)
    integer i;
    integer j;
    integer m;

    
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
    
     always @ (*) begin
         if (reset)begin //Reset repopulates pattern. When activated search starts at blocktobesearched address.
            addra = patternToBeSearched;
            for(m = 0; m<lengthPTBS; m = m +1)begin
                pattern[m] = douta;
                addra = addra +1;
            end
         end
         if (activate)begin
            for (i = blockToBeSearched ; i < (lengthBTBS - lengthPTBS)+blockToBeSearched; i = i + 1) begin
                j = 0;
                done = 0;
                while(douta != pattern[j]) begin
                    for (j = 0; j < lengthPTBS; j = j + 1) begin
                        addra <= i+j;
                    end
                    if (j == lengthPTBS) begin
                        found <= addra;//Found is updated with addra. This is different from the golden measure where it stores all the address in an array.
                    end     
                end
             end
             done = 1;
        end
     end
endmodule
