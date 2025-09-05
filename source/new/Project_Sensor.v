`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company          : Semicon_Academi
// Engineer         : Jiyun_Han
// 
// Create Date	    : 2025/07/24
// Design Name      : Project_Sensor
// Module Name      : Project_Sensor
// Target Devices   : Basys3
// Tool Versions    : 2020.2
// Description      : Final Project Top Module
//
// Revision 	    : 
//////////////////////////////////////////////////////////////////////////////////

module Project_Sensor(
    // Clock & Reset
    input           iClk,
    input           iRst,

    // FPGA SW
    input           iSet,
    input   [4:0]   iMode,      // 0 : Hour / Sec, 1 : SW, 2 : Timer, 3 : Ultra, 4 : Temp/Humid

    // FPGA Button
    input           iFPGA_Btn_U,
    input           iFPGA_Btn_D,
    input           iFPGA_Btn_R,
    input           iFPGA_Btn_L,

    // FND
    output  [3:0]   oFnd_Com,
    output  [7:0]   oFnd_Data,
    output  [3:0]   oLed_Alarm,
    output  [9:0]   oLed,

    // Ultra_Sensor
    input           iEcho,
    output          oTrig,

    // DHT_Sensor
    inout           ioDHT
    );


    /***********************************************
    // Reg & Wire
    ***********************************************/
    wire            wFPGA_Btn_U;
    wire            wFPGA_Btn_D;
    wire            wFPGA_Btn_L;
    wire            wFPGA_Btn_R;

    /***********************************************
    // Instantiation
    ***********************************************/
      

    // Butten Debouncer
    Btn_Debounce    U_Btn_U     (
        .iClk           (iClk),
        .iRst           (iRst),
        .iBtn           (iFPGA_Btn_U),
        .oBtn           (wFPGA_Btn_U)
    );

    Btn_Debounce    U_Btn_D     (
        .iClk           (iClk),
        .iRst           (iRst),
        .iBtn           (iFPGA_Btn_D),
        .oBtn           (wFPGA_Btn_D)
    );

    Btn_Debounce    U_Btn_L     (
        .iClk           (iClk),
        .iRst           (iRst),
        .iBtn           (iFPGA_Btn_L),
        .oBtn           (wFPGA_Btn_L)
    );

    Btn_Debounce    U_Btn_R     (
        .iClk           (iClk),
        .iRst           (iRst),
        .iBtn           (iFPGA_Btn_R),
        .oBtn           (wFPGA_Btn_R)
    );
/*
    // ASCII Docoder
    Decoder         U_Decoder   (
        .iClk           (iClk),
        .iRst           (iRst),
        .iAscii         (wRx_Tx_data),
        .oSet           (wPC_Set),
        .oMode          (wPC_Mode),
        .oBtn_U         (wPC_Btn_U),
        .oBtn_D         (wPC_Btn_D),
        .oBtn_L         (wPC_Btn_L),
        .oBtn_R         (wPC_Btn_R),
        .oTime_En       (wTime_En)
    );

    // Select PC_FPGA
    MUX_PC_FPGA     U_Select    (
        .iMode          (iMode),
        .iPC_Set        (wPC_Set),
        .iPC_Mode       (wPC_Mode),
        .iPC_Btn_U      (wPC_Btn_U),
        .iPC_Btn_D      (wPC_Btn_D),
        .iPC_Btn_L      (wPC_Btn_L),
        .iPC_Btn_R      (wPC_Btn_R),
        .iFPGA_Set      (iFPGA_Set),
        .iFPGA_Mode     (iFPGA_Mode),
        .iFPGA_Btn_U    (wFPGA_Btn_U),
        .iFPGA_Btn_D    (wFPGA_Btn_D),
        .iFPGA_Btn_L    (wFPGA_Btn_L),
        .iFPGA_Btn_R    (wFPGA_Btn_R),
        .oSet           (wSet),
        .oMode          (wMode),
        .oBtn_U         (wBtn_U),
        .oBtn_D         (wBtn_D),
        .oBtn_R         (wBtn_R),
        .oBtn_L         (wBtn_L)
    );
*/
    // Digital Clock & SenSor
    Sensor_Clock   U_Sensor_Clock   (
        .iClk           (iClk),
        .iRst           (iRst),
        .iSet           (iSet),
        .iMode          (iMode),
        .iBtn_U         (wFPGA_Btn_U),
        .iBtn_D         (wFPGA_Btn_D),
        .iBtn_L         (wFPGA_Btn_L),
        .iBtn_R         (wFPGA_Btn_R),
        .oFnd_Com       (oFnd_Com),
        .oFnd_Data      (oFnd_Data),
        .oLed_Alarm     (oLed_Alarm),
        .oLed           (oLed),
        .oDigit_Hour_10 (wAscii_Hour_10),
        .oDigit_Hour_1  (wAscii_Hour_1),
        .oDigit_Min_10  (wAscii_Min_10),
        .oDigit_Min_1   (wAscii_Min_1),
        .oDigit_Sec_10  (wAscii_Sec_10),
        .oDigit_Sec_1   (wAscii_Sec_1),
        .oDigit_mSec_10 (wAscii_mSec_10),
        .oDigit_mSec_1  (wAscii_mSec_1),
        .iEcho          (iEcho),
        .oTrig          (oTrig),
        .ioDHT          (ioDHT)
    );
/*
    // UART_FIFO
    
    
    // Encoder
    Encoder         U_EnHour_10 (
        .iDec           (wDigit_Hour_10),
        .oAscii         (oAscii_Hour_10)
    );

    Encoder         U_EnHour_1  (
        .iDec           (wDigit_Hour_1),
        .oAscii         (oAscii_Hour_1)
    );

    Encoder         U_EnMin_10  (
        .iDec           (wDigit_Min_10),
        .oAscii         (oAscii_Min_10)
    );

    Encoder         U_EnMin_1   (
        .iDec           (wDigit_Min_1),
        .oAscii         (oAscii_Min_1)
    );

    Encoder         U_EnSec_10  (
        .iDec           (wDigit_Sec_10),
        .oAscii         (oAscii_Sec_10)
    );

    Encoder         U_EnSec_1   (
        .iDec           (wDigit_Sec_1),
        .oAscii         (oAscii_Sec_1)
    );

    Encoder         U_EnmSec_10 (
        .iDec           (wDigit_mSec_10),
        .oAscii         (oAscii_mSec_10)
    );

    Encoder         U_EnmSec_1  (
        .iDec           (wDigit_mSec_1),
        .oAscii         (oAscii_mSec_1)
    );

    // Clock to UART
    ASCII_Tx_FSM        U_ASCII (
        .iClk           (iClk),
        .iRst           (iRst),
        .iFull          (wTx_Full),
        .iTime_En       (wTime_En),
        //.iSend_En       (wSend_En),
        .iAscii_Hour_10 (wAscii_Hour_10),
        .iAscii_Hour_1  (wAscii_Hour_1),
        .iAscii_Min_10  (wAscii_Min_10),
        .iAscii_Min_1   (wAscii_Min_1),
        .iAscii_Sec_10  (wAscii_Sec_10),
        .iAscii_Sec_1   (wAscii_Sec_1),
        .oPush          (wPush),
        .oAscii         (wAscii)
    );
    */
endmodule
