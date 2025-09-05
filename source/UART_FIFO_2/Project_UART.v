`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company          : Semicon_Academi
// Engineer         : Jiyun_Han
// 
// Create Date	    : 2025/07/21
// Design Name      : Project_UART_FIFO
// Module Name      : Project_UART
// Target Devices   : Basys3
// Tool Versions    : 2020.2
// Description      : UART + FIFO + Clock
//
// Revision 	    : 
//////////////////////////////////////////////////////////////////////////////////

module Project_UART(
    // Clock & Reset
    input           iClk,
    input           iRst,

    // Select Pc Or FPGA
    input           iMode,

    // Connect PC
    input           iRx,
    output          oTx,

    // FPGA Input
    input           iFPGA_Set,
    input   [3:0]   iFPGA_Mode,
    input           iFPGA_Btn_U,
    input           iFPGA_Btn_D,
    input           iFPGA_Btn_L,
    input           iFPGA_Btn_R,

    // FND Segment
    output  [3:0]   oFnd_Com,
    output  [7:0]   oFnd_Data,
    output  [3:0]   oLed_Alarm,
    output  [7:0]   oLed
    );


    /***********************************************
    // Reg & Wire
    ***********************************************/
    // UART_FIFO Loop
    wire            wTx_Busy;
    wire            wRx_Done;
    wire            wTx_Full;
    wire            wRx_Full;
    wire            wTx_Empty;
    wire            wRx_Empty;
    wire            wRx_Busy;
    wire    [7:0]   wTx_Data;
    wire    [7:0]   wRx_Data;
    wire    [7:0]   wRx_Tx_data;

    // FIFO_Clock
    wire    [7:0]   wAscii_Hour_10;
    wire    [7:0]   wAscii_Hour_1;
    wire    [7:0]   wAscii_Min_10;
    wire    [7:0]   wAscii_Min_1;
    wire    [7:0]   wAscii_Sec_10;
    wire    [7:0]   wAscii_Sec_1;


    // Decoder to Clock
    wire            wPC_Set;
    wire    [3:0]   wPC_Mode;
    wire            wPC_Btn_U;
    wire            wPC_Btn_D;
    wire            wPC_Btn_L;
    wire            wPC_Btn_R;

    wire            wFPGA_Set;
    wire    [3:0]   wFPGA_Mode;
    wire            wFPGA_Btn_U;
    wire            wFPGA_Btn_D;
    wire            wFPGA_Btn_L;
    wire            wFPGA_Btn_R;

    wire            wSet;
    wire    [3:0]   wMode;
    wire            wBtn_U;
    wire            wBtn_D;
    wire            wBtn_L;
    wire            wBtn_R;

    wire            wTime_En;
    wire    [7:0]   wAscii;

    /***********************************************
    // Instantiation
    ***********************************************/
    // UART
    UART            U_UART      (
        .iClk           (iClk),
        .iRst           (iRst),
        .iTx_Start      (!wTx_Empty),
        .iTx_Data       (wTx_Data),
        .iRx            (iRx),
        .oTx            (oTx),
        .oTx_Busy       (wTx_Busy),
        .oTx_Done       (),
        .oRx_Data       (wRx_Data),
        .oRx_Busy       (wRx_Busy),
        .oRx_Done       (wRx_Done)
    );

    // FIFO
    FIFO            U_Tx_FIFO   (
        .iClk           (iClk),
        .iRst           (iRst),
        .iPush          (wPush),
        .iPop           (!wTx_Busy),
        .iWrData        (wAscii),
        .oFull          (wTx_Full),
        .oEmpty         (wTx_Empty),
        .oRdData        (wTx_Data)
    );

    FIFO            U_Rx_FIFO   (
        .iClk           (iClk),
        .iRst           (iRst),
        .iPush          (wRx_Done),
        .iPop           (!wTx_Full),
        .iWrData        (wRx_Data),
        .oFull          (wRx_Full),
        .oEmpty         (wRx_Empty),
        .oRdData        (wRx_Tx_data)
    );

endmodule