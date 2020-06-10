`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2020 10:58:07
// Design Name: 
// Module Name: bram_tb
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


module bram_tb(
    );
        //Inputs
    reg clka;
    reg ena;
    reg [0:0]wea;
    reg [7:0]addra;
    reg [7:0]dina;
    //Outputs
    wire [7:0]douta;
    
    //Instantiate
      blk_mem_gen_1 bram (
      .clka(clka),    // input wire clka
      .ena(ena),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addra),  // input wire [7 : 0] addra
      .dina(dina),    // input wire [7 : 0] dina
      .douta(douta)  // output wire [7 : 0] douta
    );
    initial begin
        // Initialize Inputs
        clka = 0;
        addra = 0;
        wea <= 0;
        ena <= 1;
    end
    
    always begin
        #1 clka =~clka;
    end
    
    always@(posedge clka)begin
        addra <= addra + 1;
    end
        
endmodule
