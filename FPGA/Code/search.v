`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Vicky Feng
// 
// Create Date: 06.06.2020 21:50:10
// Design Name: 
// Module Name: search
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


module search(
    input CLK100MHZ,
    input [7:0] p,              //Address of pattern in pattern bram
    input [7:0] pl,             //length of the pattern to be searched for
    input [7:0] b,              //the address block of memory to search
    input [14:0] bl,             // length of the block address to be searched
    input activate,             // if activate clock to activate the PSA and tell it to continue searching from last address
    input reset,                //set b and clock reset to tell the PSA to start searching from address b
    output reg done,            //set to high when search ids done
    output reg [14:0] found      // returns where the pattern being searched for is found
    
    );
    
     // Memory IO
    reg ena = 1;
    reg wea = 0;
    reg [14:0] addra=0;          //The addresses will range from 0 to 249 assuming the data_250.coe is used
    reg [7:0] dina=0;           //We're not putting data in, so we can leave this unassigned
    wire [7:0] douta;           //This is a single byte from memory from a particular adress (addra)
    // pattern IO
    reg ena_p = 1;
    reg wea_p = 0;
    reg [14:0] addra_p=0;        //The addresses will range from 0 to 15 assuming the patterns_16.coe is used
    reg [7:0] dina_p=0;         //We're not putting data in, so we can leave this as is
    wire[7:0] pattern_byte;    //This is a single byte from pattern memory from a particular adress (addra_p)
    //counters
    reg [14:0] pcount=0;
    reg [14:0] bcount=0;
    //States using the one hot configuration
    parameter [6:0] RESET     = 7'b0000001;     //The initiliase block in the state mchine diagram
    parameter [6:0] CMP       = 7'b0000010;       
    parameter [6:0] CMP_TRUE  = 7'b0000100;
    parameter [6:0] CMP_FALSE = 7'b0001000;
    parameter [6:0] CONTINUE  = 7'b0010000;
    parameter [6:0] FOUND     = 7'b0100000;
    parameter [6:0] DONE      = 7'b1000000;
    reg       [6:0] state;
    //delay compare. Bram only updates output after two clock cycles.
    reg [2:0] dcount = 0;
    
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
    
    blk_mem_gen_1 pattern_bram (
      CLK100MHZ,    // input wire clka
      ena_p,      // input wire ena
      wea_p,      // input wire [0 : 0] wea
      addra_p,  // input wire [7 : 0] addra
      dina_p,    // input wire [7 : 0] dina
      pattern_byte  // output wire [7 : 0] douta
    );
    
     always@(posedge reset or posedge CLK100MHZ)begin
        addra   <= b+bcount;
        addra_p <= p+pcount;
        //Reset makes the search algorithm search from address b
        if(reset) begin
            state   <= RESET;
            found   <= 8'hff;  //If the pattern can not be found, found will be 255
            pcount  <= 0;
            bcount  <= 0;
            done    <= 0;
        end 
        else if(activate) begin
            case(state)
                RESET:      begin            
                                state   <= CMP;
                                pcount  <= 0;
                                bcount  <= 0;
                                done    <= 0;
                            end
                CMP:        begin
                                addra   <= b+bcount;
                                addra_p <= p+pcount;
                                dcount  <= dcount+1; 
                                //Wait 5 cycles before comparing because the bram outputs only update after two cycles after the input changes.
                                if(dcount==5&&douta==pattern_byte) begin
                                    bcount <= bcount + 1;
                                    pcount <= pcount + 1;
                                    dcount <= 0;
                                    state <= CMP_TRUE;        
                                end else if(dcount==5) begin
                                    pcount <= 0;
                                    bcount <= bcount + 1 - pcount;
                                    dcount <= 0;
                                    state <= CMP_FALSE;
                                end else begin
                                    state <= CMP;
                                end
                            end
                CMP_FALSE:  begin                                
                                if(bcount==bl) begin
                                    state<=DONE;
                                end else begin
                                    state<=CMP;
                                end
                            end
                CMP_TRUE:   begin       
                                if(pcount==pl) begin
                                    state <= FOUND;
                                    pcount <= 0;
                                    found  <= addra-pl+1;
                                end else if(pcount!=pl && bcount==bl) begin
                                    state <= DONE;                                   
                                end else begin
                                    state <= CMP;
                                end
                            end
                FOUND:      begin
                                if(bcount==bl) begin
                                    state <= DONE;
                                end else if(bcount<bl) begin
                                    state <= CONTINUE;
                                end
                            end
                CONTINUE:   begin                
                                pcount <= 0;
                                state  <= CMP;
                            end
                DONE:       begin
                                done   <= 1;
                            end
                default:    begin
                                state <= RESET;
                            end
            endcase
        end
     end
     
     /**always @ (posedge CLK100MHZ) begin
        if (activate)begin
            if(addra<b+bl)begin                 //Only search from the specified address up to the specified length.
                
                addra <= b + bcount;             //When bcount==bl the search ends.
                addra_p <= p + pcount;
                if(pcount==pl)begin    
                    found <= addra - pl;
                    pcount <= 0; 
                end
                if(douta==pattern_byte)begin    //The next byte of the pattern is looked at if the previous one matches memory
                    pcount <= pcount + 1;
                    bcount <= bcount + 1;
                end
                else begin
                    pcount <= 0;                 //Compare the first byte of the pattern once again
                    bcount <= bcount + 1;        //But continue to cycle through memory
                end
            end
            if(bcount==bl)
                done <= 1;
        end
     end**/
     
endmodule
