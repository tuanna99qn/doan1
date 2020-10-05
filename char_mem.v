module char_mem(
    input  [4:0] addr, // khai bao bit cua 1 ki tu 5'b10101
    output [7:0] bus  // dau ra 8 duong dia chi
    );
	 
	parameter LINES = 2;   // so dong
	parameter CHARS_PER_LINE = 16; // ki tu 1 dong
	parameter BITS_PER_CHAR = 8; // so bit 1  ki tu 
	parameter STR_SIZE = LINES * CHARS_PER_LINE * BITS_PER_CHAR; // so ki tu=256
	
	parameter [0:STR_SIZE-1] str = "HVKT-Mat Ma!    Bao cao do an 1!";

	assign bus = str[{addr[4:0], 3'b000}+:8]; //8'b10101000// lay 8 bit tu {addr[4:0], 3'b000}  ( 1 ki tu ASCII co 8 bit in ra dong HVTKMM khi i = addr//khi addr  tang thi bus=H",...
endmodule
																																														
