`timescale 1ns / 1ps

module PWM(
   input clk, //input clock
    input [7:0] pwm_in, 
    output reg pwm_out 	//output of PWM	
);


reg[7:0] counter = 0;

//100% == 255
//pwm_in is the amount of time out of 255 that the pwm_out will be on
always@(posedge clk)
begin
    if(counter < 256) counter <= counter + 1'b1;
    else counter = 0;
end 

//on up until count reaches pwm_in (think of it as the duty cycle)
always @(posedge clk) begin
    if(pwm_in > counter)begin
        pwm_out <= 1;
    end
	else 
		pwm_out <= 0;
end
	
endmodule

