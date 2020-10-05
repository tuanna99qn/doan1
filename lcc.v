module lcd (
	input            clk,
	output reg       lcd_rs,
	output reg       lcd_rw,
	output reg       lcd_e,
	output reg [7:4] lcd_d,
	output     [4:0] mem_addr,
	input      [7:0] mem_bus
	);
	
	parameter        n = 24;
	parameter        j = 17;           //khoi t?o j chay ? clk clk / 2 ^ (j + 2) ~ 95Hz 
	parameter        k = 11;            // ghi/ tim kiem nhanh clk / 2 ^ (k_2) ~ 6KHz
	parameter        noop = 6'b010000; // cho phep LCD (lcd_d, co the ghi man bat cu luc nao)
	
	reg        [n:0] count = 0;      // bien dem
	reg        [5:0] lcd_state = noop; //  trang thai ban dau ghi man
	reg              init = 1;         // khai tao nguon
	reg              row = 0;           // ghi len hang dau hoac hang duoi
	
	assign mem_addr = {row, count[k+6:k+3]}; //  ben phai la 1 biue thuc, phai thay doi thi trai moi thay doi theo
	
	//initial count[j+7:j+2] = 11;

	always @ (posedge clk) begin   // chuong trinh chinh 
		count <= count + 1;			// biem dem tang
		if (init) begin                    //  neu co nguoi thi bat dau
			case (count[j+7:j+2])				//6 bit cao
				1: lcd_state <= 6'b000010;    // // / HAM FUNCTION SET GIAO TIEP 4BIT TU D4 DEN D7
				2: lcd_state <= 6'b000010;
				3: lcd_state <= 6'b001000;			
				4: lcd_state <= 6'b000000;    // display on/off control
				5: lcd_state <= 6'b001100;
				6: lcd_state <= 6'b000000;    // display clear
				7: lcd_state <= 6'b000001;
				8: lcd_state <= 6'b000000;    // entry mode set 
				9: lcd_state <= 6'b000110;
				10: begin init <= ~init; count <= 0; end //khi tat nguon thi dung man hinh
			endcase
			// Ghi lcd_state vào màn hình LCD và chuyen lcd_ len muc cao
			{lcd_e,lcd_rs,lcd_rw,lcd_d[7:4]} <= {^count[j+1:j+0] & ~lcd_rw,lcd_state};  //lcd_state trang thai man hinh duoc gan cho lcd_d[7:4],
																												//dao rw 1 & xor count[1 :0] cua e va rs
		end else begin                                                              // lien tuc cap nhat man hinh
			case (count[k+7:k+2]) 
				32: lcd_state <= {3'b001,~row,2'b00};  //001100                              //  bat nguon va di chuyen con tro den dau dong tiep theo
				34: begin count <= 0; row <= ~row; end                                // khoi tao dong va di chuyen con tro theo ki tu duoc ghi
				default: lcd_state <= {2'b10, ~count[k+2] ? mem_bus[7:4] : mem_bus[3:0]}; // keo cac ki tu tu bus
			endcase
			// Ghi lcd_state vào màn hình LCD và chuyen lcd_ len muc cao
			{lcd_e,lcd_rs,lcd_rw,lcd_d[7:4]} <= {^count[k+1:k+0] & ~lcd_rw,lcd_state};//lcd_state trang thai man hinh duoc gan cho lcd_d[7:4],
		end
	end
endmodule