module SS_Driver(
    input Clk, Reset,
    input [3:0] BCD3, BCD2, BCD1, BCD0, // Binary-coded decimal input
    input [7:0] pwm_in,
    output reg [7:0] SegmentDrivers, // Digit drivers (active low)
    output reg [7:0] SevenSegment // Segments (active low)
);


// Make use of a subcircuit to decode the BCD to seven-segment (SS)
wire [6:0]SS[3:0];
BCD_Decoder BCD_Decoder0 (BCD0, SS[0]);
BCD_Decoder BCD_Decoder1 (BCD1, SS[1]);
BCD_Decoder BCD_Decoder2 (BCD2, SS[2]);
BCD_Decoder BCD_Decoder3 (BCD3, SS[3]);


// Counter to reduce the 100 MHz clock to 762.939 Hz (100 MHz / 2^17)
reg [16:0]Count;

wire pwm_out;

PWM pwm (Clk,pwm_in,pwm_out);

// Scroll through the digits, switching one on at a time
always @(posedge Clk) begin
 Count <= Count + 1'b1;
    if ( Reset) SegmentDrivers <= 8'hFE;
//so if the pwm is 1, the displays will be on, if pwm is 0, they will all be off.
 else if(&Count) SegmentDrivers <= {SegmentDrivers[7:4],SegmentDrivers[2:0], SegmentDrivers[3]}; 
end



//------------------------------------------------
always @(*) begin // This describes a purely combinational circuit
    SevenSegment[7] <= 1'b1; // Decimal point always off
    if (Reset) begin
        SevenSegment[6:0] <= 7'h7F; // All off during Reset
    end else begin
        case(~SegmentDrivers) // Connect the correct signals,
            8'h1 : SevenSegment[6:0] <= (pwm_out) ? ~SS[0] : 7'h7F;// depending on which digit is on at
            8'h2 : SevenSegment[6:0] <= (pwm_out) ? ~SS[1] : 7'h7F ; // this point
            8'h4 : SevenSegment[6:0] <= (pwm_out) ? ~SS[2] : 7'h7F ;
            8'h8 : SevenSegment[6:0] <= (pwm_out) ? ~SS[3] : 7'h7F;
            default: SevenSegment[6:0] <= 7'h7F;
        endcase
    end
end

endmodule
