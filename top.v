`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:31:04 08/24/2020
// Design Name:   top
// Module Name:   D:/PROJECT/DO_AN_1/LCD/top.v
// Project Name:  LCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top;

	// Inputs
	reg clk;

	// Outputs
	wire lcd_rs;
	wire lcd_rw;
	wire lcd_e;
	wire [11:8] sf_d;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.lcd_rs(lcd_rs), 
		.lcd_rw(lcd_rw), 
		.lcd_e(lcd_e), 
		.sf_d(sf_d)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

