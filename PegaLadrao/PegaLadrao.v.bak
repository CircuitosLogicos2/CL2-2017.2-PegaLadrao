
module PegaLadrao(input [17:0] SW, input CLK_50,input [3:0] BT, output reg [17:0] LEDR, output reg [7:0] LEDG, output segA, segB, segC, segD, segE, segF, segG,segDP,
				  input clk,output segA1, segB1, segC1, segD1, segE1, segF1, segG1, segDP1,segA2, segB2, segC2, segD2, segE2, segF2, segG2,segDP2,
				  segA5, segB5, segC5, segD5, segE5, segF5, segG5, segDP5, segA6, segB6, segC6, segD6, segE6, segF6, segG6, segDP6, segA3, segB3, segC3,
				  segD3, segE3, segF3, segG3, segDP3, segA4, segB4, segC4, segD4, segE4, segF4, segG4, segDP4,
				  output reg LEDVenceu);
				 /* inout [35:0] GPIO_0,GPIO_1,    //    GPIO Connections
				  output LCD_ON,        // LCD Power ON/OFF
				  output LCD_BLON,      // LCD Back Light ON/OFF
				  output LCD_RW,        // LCD Read/Write Select, 0 = Write, 1 = Read
				  output LCD_EN,        // LCD Enable
				  output LCD_RS,        // LCD Command/Data Select, 0 = Command, 1 = Data
				  inout [7:0] LCD_DATA  // LCD Data bus 8 bits
	);

//    All inout port turn to tri-state
assign    GPIO_0        =    36'hzzzzzzzzz;
assign    GPIO_1        =    36'hzzzzzzzzz;

// Reset delay gives some time for peripherals to initialize
wire DLY_RST;

// Turn LCD ON
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
*/		
	reg [23:0] cnt,cnt1,cnt2;
	reg [3:0] uniPoint = 4'h0, dezPoint = 4'h0;
	reg [3:0] uniHit = 4'h0, dezHit = 4'h0;
	
	always @(posedge clk) begin 
		cnt <= cnt+24'h1;
		cnt1 <= cnt1 +24'h1;
		cnt2 <= cnt2 +24'h1;
	end
	wire cntovf = &cnt;
	wire cntovf1 = &cnt1;
	wire cntovf2 = &cnt2;
	// UNI is a counter that counts from 0 to 9
	reg [3:0] UNI;
	reg [3:0] DEZ;
	reg [3:0] CEN = 3;
	reg [17:0] ladrao = 0;
	reg [17:0] array;
	integer hitU = 0;
	integer hitD = 0;
	integer i = 0; 
	integer flag = 0;
	integer acende = 0;
	reg jaContou, mudou, venceu, zeraEssaMizera, acabouOTempo;
	reg [3:0]level = 3'b0000;
	
	always @(posedge clk) begin
		if(acende == 1)begin
			LEDVenceu = 1'b1;
		end
		else LEDVenceu = 1'b0;
		if(cntovf) begin 
			UNI <= (UNI==4'h0 ? 4'h9 : UNI-4'h1);
		end
		if(UNI == 0)
			if(cntovf1) begin 
				DEZ <= (DEZ==4'h0 ? 4'h5 : DEZ-4'h1);
			end
		if(DEZ == 0 && UNI == 0)
			if(cntovf2) begin
				CEN <= CEN - 1;
			end
		
		zeraEssaMizera = 1'b0;
		if(uniHit == uniPoint && dezHit == dezPoint)
			zeraEssaMizera = 1'b1;
			
		if(UNI==1 && DEZ == 0 && CEN == 0)
			acabouOTempo = 1'b1;
			
		if((UNI == 0 && DEZ == 0 && CEN == 0) || level == 4'b0000 || venceu == 1'b1)begin
			UNI <= 1;
			DEZ <= 0;
			CEN <= 0;
			level = 4'b0000;
			dezPoint = 4'h0;
			uniPoint = 4'h0;
		end
		if(level == 4'b0000 && ~BT) begin      // RESET DO JOGO
			CEN <= 3;
			UNI <= 0;
			DEZ <= 0;
			acabouOTempo = 1'b0;
		end
		if(BT == 4'b1110 && level == 4'b0000) begin
			level = 4'b0001;
			dezPoint = 4'h1;
			uniPoint = 4'h0;
		end
		if(BT == 4'b1101 && level == 4'b0000) begin
			level = 4'b0010;
			dezPoint = 4'h1;
			uniPoint = 4'h5;
		end
		if(BT == 4'b1011 && level == 4'b0000) begin
			level = 4'b0011;
			dezPoint = 4'h2;
			uniPoint = 4'h0;
		end
		if(BT == 4'b0111 && level == 4'b0000) begin
			level = 4'b0100;
			dezPoint = 4'h3;
			uniPoint = 4'h0;
		end
	end
	reg [7:0] SevenSeg;
	always @(*)
	case(UNI)
		4'h0: SevenSeg = 8'b11111100;
		4'h1: SevenSeg = 8'b01100000;
		4'h2: SevenSeg = 8'b11011010;
		4'h3: SevenSeg = 8'b11110010;
		4'h4: SevenSeg = 8'b01100110;
		4'h5: SevenSeg = 8'b10110110;
		4'h6: SevenSeg = 8'b10111110;
		4'h7: SevenSeg = 8'b11100000;
		4'h8: SevenSeg = 8'b11111110;
		4'h9: SevenSeg = 8'b11110110;
		default: SevenSeg = 8'b00000000;
	endcase

	assign {segA, segB, segC, segD, segE, segF, segG,segDP} = ~SevenSeg;
	
	reg [7:0] SevenSeg1;
	always @(*)
	case(DEZ)
		4'h0: SevenSeg1 = 8'b11111100;
		4'h1: SevenSeg1 = 8'b01100000;
		4'h2: SevenSeg1 = 8'b11011010;
		4'h3: SevenSeg1 = 8'b11110010;
		4'h4: SevenSeg1 = 8'b01100110;
		4'h5: SevenSeg1 = 8'b10110110;
		4'h6: SevenSeg1 = 8'b10111110;
		4'h7: SevenSeg1 = 8'b11100000;
		4'h8: SevenSeg1 = 8'b11111110;
		4'h9: SevenSeg1 = 8'b11110110;
		default: SevenSeg1 = 8'b00000000;
	endcase

	assign {segA1, segB1, segC1, segD1, segE1, segF1, segG1,segDP1} = ~SevenSeg1;
	
	reg [7:0] SevenSeg2;
	always @(*)
	case(CEN)
		4'h0: SevenSeg2 = 8'b11111100;
		4'h1: SevenSeg2 = 8'b01100000;
		4'h2: SevenSeg2 = 8'b11011010;
		4'h3: SevenSeg2 = 8'b11110010;
		4'h4: SevenSeg2 = 8'b01100110;
		4'h5: SevenSeg2 = 8'b10110110;
		4'h6: SevenSeg2 = 8'b10111110;
		4'h7: SevenSeg2 = 8'b11100000;
		4'h8: SevenSeg2 = 8'b11111110;
		4'h9: SevenSeg2 = 8'b11110110;
		default: SevenSeg2 = 8'b00000000;
	endcase

	assign {segA2, segB2, segC2, segD2, segE2, segF2, segG2,segDP2} = ~SevenSeg2;
	
	reg [7:0] SevenSegUniP;
	always @(*)
	case(uniPoint)
		4'h0: SevenSegUniP = 8'b11111100;
		4'h1: SevenSegUniP = 8'b01100000;
		4'h2: SevenSegUniP = 8'b11011010;
		4'h3: SevenSegUniP = 8'b11110010;
		4'h4: SevenSegUniP = 8'b01100110;
		4'h5: SevenSegUniP = 8'b10110110;
		4'h6: SevenSegUniP = 8'b10111110;
		4'h7: SevenSegUniP = 8'b11100000;
		4'h8: SevenSegUniP = 8'b11111110;
		4'h9: SevenSegUniP = 8'b11110110;
		default: SevenSegUniP = 8'b00000000;
	endcase
	
	assign {segA5, segB5, segC5, segD5, segE5, segF5, segG5,segDP5} = ~SevenSegUniP;
	
	
	reg [7:0] SevenSegDezP;
	always @(*)
	case(dezPoint)
		4'h0: SevenSegDezP = 8'b11111100;
		4'h1: SevenSegDezP = 8'b01100000;
		4'h2: SevenSegDezP = 8'b11011010;
		4'h3: SevenSegDezP = 8'b11110010;
		4'h4: SevenSegDezP = 8'b01100110;
		4'h5: SevenSegDezP = 8'b10110110;
		4'h6: SevenSegDezP = 8'b10111110;
		4'h7: SevenSegDezP = 8'b11100000;
		4'h8: SevenSegDezP = 8'b11111110;
		4'h9: SevenSegDezP = 8'b11110110;
		default: SevenSegDezP = 8'b00000000;
	endcase
	
	assign {segA6, segB6, segC6, segD6, segE6, segF6, segG6,segDP6} = ~SevenSegDezP;
	
	reg [7:0] SevenSegUniH;
	always @(*)
	case(uniHit)
		4'h0: SevenSegUniH = 8'b11111100;
		4'h1: SevenSegUniH= 8'b01100000;
		4'h2: SevenSegUniH = 8'b11011010;
		4'h3: SevenSegUniH = 8'b11110010;
		4'h4: SevenSegUniH = 8'b01100110;
		4'h5: SevenSegUniH = 8'b10110110;
		4'h6: SevenSegUniH = 8'b10111110;
		4'h7: SevenSegUniH = 8'b11100000;
		4'h8: SevenSegUniH = 8'b11111110;
		4'h9: SevenSegUniH = 8'b11110110;
		default: SevenSegUniH = 8'b00000000;
	endcase
	
	assign {segA3, segB3, segC3, segD3, segE3, segF3, segG3, segDP3} = ~SevenSegUniH;
	
	reg [7:0] SevenSegDezH;
	always @(*)
	case(dezHit)
		4'h0: SevenSegDezH = 8'b11111100;
		4'h1: SevenSegDezH = 8'b01100000;
		4'h2: SevenSegDezH = 8'b11011010;
		4'h3: SevenSegDezH = 8'b11110010;
		4'h4: SevenSegDezH = 8'b01100110;
		4'h5: SevenSegDezH = 8'b10110110;
		4'h6: SevenSegDezH = 8'b10111110;
		4'h7: SevenSegDezH = 8'b11100000;
		4'h8: SevenSegDezH = 8'b11111110;
		4'h9: SevenSegDezH = 8'b11110110;
		default: SevenSegDezH = 8'b00000000;
	endcase
	
	assign {segA4, segB4, segC4, segD4, segE4, segF4, segG4, segDP4} = ~SevenSegDezH;
	
	integer number = 0;
	integer countTime = 0;
	always@(posedge UNI) begin 
	venceu = 1'b0;
		if(level) begin
			if(countTime == 0)begin
				for(i = 0; i < level; i = i + 1) begin

					array[0] = !array[1];
					array[1] = !array[2] ^ array[1];
					array[2] = !array[3];
					array[3] = !array[4] ^ array[1];
					array[4] = !array[5] ^ array[1];
					array[5] = !array[6] ^ array[1];
					array[6] = !array[7] ^ array[1];
					array[7] = !array[8];
					array[8] = !array[9] ^ array[1];
					array[9] = !array[10] ^ array[1];
					array[10] = !array[11];
					array[11] = !array[12];
					array[12] = !array[13] ^ array[1];
					array[13] = !array[14];
					array[14] = !array[15] ^ array[1];
					array[15] = !array[16] ^ array[1];
					array[16] = !array[17] ^ array[1];
					array[17] = !array[10];
					number = array%18;
					ladrao[number] = 1;
					mudou = 1'b1;
				end
			end
			
			LEDR = ladrao;
			if(ladrao != 18'b000000000000000000 && ladrao == SW) begin
				acende = 0;
				LEDG = 8'b00000001;
				if(jaContou == 1'b0)begin
					hitU = hitU +  1;
					jaContou = 1'b1;
				end
				if(hitU > 9)begin
					hitU = 0;
					hitD = hitD + 1;
				end
				
				if(hitD>10) hitD = 0;
				uniHit = hitU;
				dezHit = hitD;
				
			end	else LEDG = 8'b00000000;
			if(mudou == 1'b1)begin
					jaContou = 1'b0;
			end
			
			
			countTime = countTime + 1;
			if(countTime == 3)begin
				ladrao = 18'b000000000000000000;
				mudou = 1'b0;				
				countTime = 0;
			end
			if(zeraEssaMizera == 1'b1 || acabouOTempo == 1'b1)begin
				dezHit = 1'h0;
				uniHit = 1'h0;
				if(zeraEssaMizera == 1'b1)begin
					venceu = 1'b1;
					acende <= 1;
				end
				hitU = 0;
				hitD = 0;
			end

		end
		
	end

endmodule