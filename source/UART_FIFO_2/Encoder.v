`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company          : Semicon_Academi
// Engineer         : Jiyun_Han
// 
// Create Date	    : 2025/07/22
// Design Name      : Project_UART_FIFO
// Module Name      : Encoder
// Target Devices   : Basys3
// Tool Versions    : 2020.2
// Description      : ASCII Encoder
//
// Revision 	    : 
//////////////////////////////////////////////////////////////////////////////////


module Encoder(
    input   [3:0]   iDec,

    output  [7:0]   oAscii
    );

    reg     [7:0]   rAscii;

    always  @(*)
    begin
        if  (iDec <= 4'h9)
            rAscii  = iDec + 8'h30;
        else
            rAscii  = 8'h30;
    end

    assign  oAscii  = rAscii;

endmodule
