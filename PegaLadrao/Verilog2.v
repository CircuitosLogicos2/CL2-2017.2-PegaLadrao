
module LED_7seg(segA, segB, segC, segD, segE, segF, segG, segDP);
output segA, segB, segC, segD, segE, segF, segG, segDP;

assign {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b11011010;   // light the leds to display '2'
endmodule
