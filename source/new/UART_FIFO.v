`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company          : Semicon_Academi
// Engineer         : Jiyun_Han
// 
// Create Date	    : 2025/07/25
// Design Name      : Project_Sensor
// Module Name      : UART_FIFO
// Target Devices   : Basys3
// Tool Versions    : 2020.2
// Description      : UART_FIFO Top Module
//////////////////////////////////////////////////////////////////////////////////

module UART_FIFO(
    // Clock & Reset
    input           iClk,
    input           iRst,
    
    // Tx_FIFO
    input           iPush,
    input   [7:0]   iAscii,
    output          oTx_Full,

    // Rx_FIFO
    input           iPop,
    output          oRx_Empty,
    output          oRx_Data,

    // UART
    input           iRx,
    output          oTx
    );


    /***********************************************
    // Reg & Wire
    ***********************************************/
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

    /***********************************************
    // Instantiation
    ***********************************************/
    // UART
    UART    U_UART      (
        .iClk       (iClk),
        .iRst       (iRst),
        .iTx_Start  (!wTx_Empty),
        .iTx_Data   (wTx_Data),
        .iRx        (iRx),
        .oTx        (oTx),
        .oTx_Busy   (wTx_Busy),
        .oTx_Done   (),
        .oRx_Data   (wRx_Data),
        .oRx_Busy   (wRx_Busy),
        .oRx_Done   (wRx_Done)
    );

    // FIFO
    FIFO    U_Tx_FIFO   (
        .iClk       (iClk),
        .iRst       (iRst),
        .iPush      (!wRx_Empty),
        .iPop       (!wTx_Busy),
        .iWrData    (wRx_Tx_data),
        .oFull      (wTx_Full),
        .oEmpty     (wTx_Empty),
        .oRdData    (wTx_Data)
    );

    FIFO    U_Rx_FIFO   (
        .iClk       (iClk),
        .iRst       (iRst),
        .iPush      (wRx_Done),
        .iPop       (!wTx_Full),
        .iWrData    (wRx_Data),
        .oFull      (wRx_Full),
        .oEmpty     (wRx_Empty),
        .oRdData    (wRx_Tx_data)
    );
endmodule
