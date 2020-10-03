
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2020 01:15:33 PM
// Design Name: 
// Module Name: SPI_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

    
module LCD_SPI_controller_16_bit(
   input        i_Rst_H,     // FPGA Reset
   input        i_Clk,       // FPGA Clock
   output reg   o_led,
   output       o_SPI_LCD_Clk,
   input        i_SPI_LCD_MISO,
   output       o_SPI_LCD_MOSI,
   output       o_SPI_LCD_CS_n,
   output   reg o_LCD_DC,
   output   reg o_LCD_reset_n
    );
    
   reg [3:0]  o_TX_LCD_Count;  // # bytes per CS low
   reg [7:0]  o_TX_LCD_Byte;       // Byte to transmit on MOSI
   reg        o_TX_LCD_DV;         // Data Valid Pulse with i_TX_Byte
   wire       i_TX_LCD_Ready;      // Transmit Ready for next byte
   
   // RX (MISO) Signals
   wire [3:0] i_RX_LCD_Count;  // Index RX byte
   wire       i_RX_LCD_DV;     // Data Valid pulse (1 clock cycle)
   wire [7:0] i_RX_LCD_Byte;   // Byte received on MISO
    
   reg [31:0] r_timeout_counter;
   reg [31:0] r_timeout_max;  
   
   reg [15:0] r_SM_msg;
   reg e_ram_enable;
   reg [15:0]  r_PC;
   wire [15:0] w_opcode;
   wire [15:0] w_var1;
   wire [15:0] w_var2;
   
   //reg [15:0] r_instruction; 
   
   reg [15:0] r_register_a;
   reg [15:0] r_register_b;
   reg [15:0] r_register_c;
   reg        r_zero_flag;
   
   SPI_Master_With_Single_CS SPI_Master_With_Single_CS_inst (
   .i_Rst_L(~i_Rst_H),     // FPGA Reset
   .i_Clk(i_Clk),       // FPGA Clock
   
   // TX (MOSI) Signals
   .i_TX_Count(o_TX_LCD_Count),  // # bytes per CS low
   .i_TX_Byte(o_TX_LCD_Byte),       // Byte to transmit on MOSI
   .i_TX_DV(o_TX_LCD_DV),         // Data Valid Pulse with i_TX_Byte
   .o_TX_Ready(i_TX_LCD_Ready),      // Transmit Ready for next byte
   
   // RX (MISO) Signals
   .o_RX_Count(i_RX_LCD_Count),  // Index RX byte
   .o_RX_DV(i_RX_LCD_DV),     // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(i_RX_LCD_Byte),   // Byte received on MISO

   // SPI Interface
   .o_SPI_Clk(o_SPI_LCD_Clk),
   .i_SPI_MISO(i_SPI_LCD_MISO),
   .o_SPI_MOSI(o_SPI_LCD_MOSI),
   .o_SPI_CS_n(o_SPI_LCD_CS_n));
   
  rams_sp_nc rams_sp_nc1 (
    .clk(i_Clk),
    .en(e_ram_enable),
    .addr(r_PC),
    .dout_opcode(w_opcode),
    .dout_var1(w_var1),
    .dout_var2(w_var2));

   ila_0  myila(.clk(i_Clk),
   .probe0(w_opcode),
   .probe1(w_var1),
   .probe2(r_PC),
   .probe3(r_SM_msg),
   .probe4(e_ram_enable),
   .probe5(o_TX_LCD_Byte),
   .probe6(8'b0),
   .probe7(r_register_a),
   .probe8(o_SPI_LCD_Clk),
   .probe9(i_SPI_LCD_MISO),
   .probe10(o_SPI_LCD_MOSI),
   .probe11(o_SPI_LCD_CS_n),
   .probe12(o_LCD_DC),
   .probe13(o_LCD_reset_n),
   .probe14(r_flags),
   .probe15(1'b0));
     
    `include "timing_tasks.vh" 
    `include "LCD_tasks.vh" 
    `include "led_tasks.vh"  
    `include "register_tasks.vh"         
    
    initial
    begin
        r_SM_msg=15'b0;
        r_PC<=15'b0;
        r_timeout_counter=32'b0;
    end
    
    initial
    begin
        o_TX_LCD_Count=4'd1;
        o_TX_LCD_Byte=8'b0; 
        r_SM_msg=0;
        r_timeout_counter=0;
        o_LCD_reset_n=1'b0; 
        r_register_a=16'h0;
        r_register_b=16'h0;
        r_register_c=16'h0;
        r_PC=16'h0;
        r_zero_flag=0;
    end
    
    always @(posedge i_Clk)
    begin
        if (i_Rst_H)
        begin
            o_TX_LCD_Count=4'd1;
            o_TX_LCD_Byte=8'b0;  
            r_SM_msg=0;
            r_timeout_counter=0;
            o_LCD_reset_n=1'b0; 
            r_register_a=16'h0;
            r_register_b=16'h0;
            r_register_c=16'h0;
            r_PC=16'h0;
            r_zero_flag=0;
        end // if (i_Rst_H)
        else
        begin
            case(r_SM_msg)               
                0: 
                begin
                    e_ram_enable<=1;
                    r_SM_msg=r_SM_msg+1;
                end 
                1: 
                begin
                    e_ram_enable<=0;
                    r_SM_msg=r_SM_msg+1;
                end
                2: 
                begin
                    //r_instruction<=w_instruction;
                    r_SM_msg=r_SM_msg+1;
                end  
                3:
                begin
                    case(w_opcode[15:0])
                    
                    16'h2001: spi_dc_write_command(w_var1);
                    16'h2002: spi_dc_write_data(w_var1);
                    16'h2003: t_delay(w_var1);
                    16'h2004: t_led_state(w_var1[0]);
                    16'h2005: t_lcd_reset(w_var1[0]);
                    16'h0110: t_set_reg_a(w_var1);
                    16'h0111: t_inc_reg_a(w_var1);
                    16'h0112: t_dec_reg_a(w_var1);
                    16'h0113: t_jump_if_zero_forward(w_var1);
                    16'h0114: t_jump_if_zero_backwards(w_var1);
                    16'h0115: t_jump_if_not_zero_forward(w_var1);
                    16'h0116: t_jump_if_not_zero_backwards(w_var1);
                    16'hFFFF: 
                    begin
                        r_SM_msg<=r_SM_msg+1;  
                        r_PC<=0;
                    end                 
                    default: 
                    begin
                        r_SM_msg<=0; 
                        r_PC<= r_PC+1;
                    end
                endcase
                end
                
           
                default: r_SM_msg<=0; // loop in error
            endcase // case(r_SM_msg)         
        end // else if (i_Rst_H)
    end // always @(posedge i_Clk)
    
endmodule