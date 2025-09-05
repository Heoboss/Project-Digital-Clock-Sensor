`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company          : Semicon_Academi
// Engineer         : Jiyun_Han
// 
// Create Date	    : 2025/07/22
// Design Name      : Project_UART_FIFO
// Module Name      : ASCII_Tx_FSM
// Target Devices   : Basys3
// Tool Versions    : 2020.2
// Description      : ASCII Encoder
//
// Revision 	    : 
//////////////////////////////////////////////////////////////////////////////////


module ASCII_Tx_FSM(
    input           iClk,
    input           iRst,

    input           iFull,
    input           iTime_En,
    //input           iSend_En,

    input   [7:0]   iAscii_Hour_10,
    input   [7:0]   iAscii_Hour_1,
    input   [7:0]   iAscii_Min_10,
    input   [7:0]   iAscii_Min_1,
    input   [7:0]   iAscii_Sec_10,
    input   [7:0]   iAscii_Sec_1,

    output          oPush,
    output  [7:0]   oAscii
    );

    // Reg & Wire
    reg     [7:0]   rAscii[0:7];
    reg     [3:0]   rIdx;
    reg             rSending;

    reg             rPush;
    reg     [7:0]   rOut_Ascii;

    always  @(posedge iClk)
    begin
        if (iRst)
        begin
            rOut_Ascii  <= 0;
            rIdx        <= 0;
            rPush       <= 0;
            rSending    <= 0;
        end else
        begin
            rPush       <= 0;

            if  (iTime_En && !rSending)
            begin
                rAscii[0]   <= iAscii_Hour_10;
                rAscii[1]   <= iAscii_Hour_1;
                rAscii[2]   <= ":";
                rAscii[3]   <= iAscii_Min_10;
                rAscii[4]   <= iAscii_Min_1;
                rAscii[5]   <= ":";
                rAscii[6]   <= iAscii_Sec_10;
                rAscii[7]   <= iAscii_Sec_1;

                rIdx        <= 0;
                rSending    <= 1;           
            end else if (rSending && !iFull)
            begin
                rOut_Ascii  <= rAscii[rIdx];
                rPush       <= 1;
                rIdx        <= rIdx + 1;

                if  (rIdx == 7)
                begin
                    rSending    <= 0;
                    rIdx        <= 0;
                end
            end
        end
    end

    assign  oPush   = rPush;
    assign  oAscii  = rOut_Ascii;

endmodule