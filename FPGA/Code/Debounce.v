`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2020 05:34:10 PM
// Design Name: 
// Module Name: clkDevider
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


module Debounce(
    input CLK100MHZ, 
    input  button,//can be 1 or zeroc
    output reg out
);

reg [21:0]Count; //assume count is null on FPGA configuration
reg status;
initial 
begin
    Count <= 21'b0;
    status <= 1'b1;
end

//--------------------------------------------
always @(posedge CLK100MHZ) begin 
    // implement your logic here
    if (Count >= 20000) begin ///have we allowed debounce?
        if ((button == 1'b1) && (status == 1'b1)) begin//now check if the button was pressed
            status <= 1'b0; // clears the the status to show pressing
        end
        
        if (button == 1'b0) begin // is the button released
            status <= 1'b1;
        end
        out = button;
        Count = 0;//restart the counter
    end
    else begin
        Count <= Count+1;//when debounce timer is not up keep incrementing the count
    end
end 
endmodule