
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
   input        i_uart_rx,
   output reg   o_led,
   output reg   o_led_2,
   output       o_SPI_LCD_Clk,
   input        i_SPI_LCD_MISO,
   output       o_SPI_LCD_MOSI,
   output       o_SPI_LCD_CS_n,
   output   reg o_LCD_DC,
   output   reg o_LCD_reset_n,
   output      [3:0]   o_Anode_Activate, // anode signals of the 7-segment LED display
   output      [7:0]   o_LED_cathode// cathode patterns of the 7-segment LED display
    );
    
   parameter STACK_SIZE=1024;
   parameter OPCODE_REQUEST=4'h0, OPCODE_FETCH=4'h1, OPCODE_EXECUTE=4'h2, HCF_1=4'h3,HCF_2=4'h4,  HCF_3=4'h5, HCF_4=4'h6;
   parameter ERR_INV_OPCODE=8'h1, ERR_INV_FSM_STATE=8'h2, ERR_STACK=8'h3;
    
   // UART receive control
   wire [7:0]    w_uart_rx_value;  // Received value
   wire          w_uart_rx_DV;     // receive flag
   
   // LCD control
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
   
   // Machine control
   reg [3:0] r_SM_msg;
   reg e_ram_enable;
   reg [15:0]  r_PC;
   wire [15:0] w_opcode;
   wire [15:0] w_var1;
   wire [15:0] w_var2;
   
   // Register control
   reg [15:0] r_register[7:0];
   reg        r_zero_flag;
   reg        r_equal_flag;
   reg [7:0]  r_error_code;
   
   // Display value
   reg [31:0] r_seven_seg_value;
   
   // Stack control   
   wire [15:0] i_stack_top_value;
   wire        i_stack_error;
   reg         o_stack_read_flag;
   reg         o_stack_write_flag;
   reg  [15:0] o_stack_write_value;
   
   // DEBUG
   reg [7:0] rx_count;
   
   uart_receive uart_receive1(
.clk(i_Clk), //input clock
.reset(i_Rst_H), //input reset 
.RxD(i_uart_rx), //input receving data line
.RxData(w_uart_rx_value), // output for 8 bits data
.RxDV(w_uart_rx_DV));
   
 stack main_stack (
.clk(i_Clk),
.i_reset(i_Rst_H),
.i_read_flag(o_stack_read_flag),
.i_write_flag(o_stack_write_flag),
.i_write_value(o_stack_write_value),
.o_stack_top_value(i_stack_top_value),
.o_stack_error(i_stack_error));
   
   Seven_seg_LED_Display_Controller Seven_seg_LED_Display_Controller1 (
    .i_sysclk(i_Clk),
    .i_reset(i_Rst_H), 
    .i_displayed_number(r_seven_seg_value), // Number to display
    .o_Anode_Activate(o_Anode_Activate), 
    .o_LED_cathode(o_LED_cathode)
    );
    
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
    .read_en(e_ram_enable),
    .addr(r_PC),
    .dout_opcode(w_opcode),
    .dout_var1(w_var1),
    .dout_var2(w_var2));

  /* ila_0  myila(.clk(i_Clk),
   .probe0(w_opcode),
   .probe1(r_check_number),
   .probe2(r_PC),
   .probe3(r_SM_msg),
   .probe4(w_uart_rx_value),
   .probe5(o_TX_LCD_Byte),
   .probe6(8'b0),
   .probe7(r_register[0]),
   .probe8(o_SPI_LCD_Clk),
   .probe9(i_SPI_LCD_MISO),
   .probe10(o_SPI_LCD_MOSI),
   .probe11(o_SPI_LCD_CS_n),
   .probe12(o_LCD_DC),
   .probe13(o_LCD_reset_n),
   .probe14(r_zero_flag),
   .probe15(1'b0));*/
     
    `include "timing_tasks.vh" 
    `include "LCD_tasks.vh" 
    `include "led_tasks.vh"  
    `include "register_tasks.vh" 
    `include "control_tasks.vh"     
    `include "stack_tasks.vh"     
    
    
    initial
    begin
        o_TX_LCD_Count=4'd1;
        o_TX_LCD_Byte=8'b0; 
        r_SM_msg=OPCODE_REQUEST;
        r_timeout_counter=0;
        o_LCD_reset_n=1'b0; 
        r_PC=16'h0;
        r_zero_flag=0;
        r_error_code=8'h0;
        r_timeout_counter=32'b0;
        r_seven_seg_value=32'h20_10_00_01;
        o_led_2=1'b1;
    end
    
    always @(posedge i_Clk)
    begin
        if(w_uart_rx_DV)
        begin
            o_led_2 <=~o_led_2; 
            rx_count<=rx_count+1;    
        end
        if (i_Rst_H)
        begin
            o_TX_LCD_Count=4'd1;
            o_TX_LCD_Byte=8'b0;  
            r_SM_msg=OPCODE_REQUEST;
            r_timeout_counter=0;
            o_LCD_reset_n=1'b0; 
            r_PC=16'h0;
            r_zero_flag=0;
            r_error_code=8'h0;
        end // if (i_Rst_H)
        else
        begin
            case(r_SM_msg)               
                OPCODE_REQUEST: 
                begin
                o_stack_write_flag<=1'b0;
                o_stack_read_flag<=1'b0;
                if(i_stack_error) 
                    begin
                        r_SM_msg<=HCF_1; // Halt and catch fire error 1 
                        r_error_code<=ERR_STACK;
                    end // default case
                    else
                    begin
                        e_ram_enable<=1;
                        r_SM_msg<=OPCODE_FETCH;
                    end
                end 
                OPCODE_FETCH: 
                begin
                    e_ram_enable<=0;
                    r_SM_msg<=OPCODE_EXECUTE;
                end  
                OPCODE_EXECUTE:
                begin
                    //e_ram_enable<=0;
                    casez(w_opcode[15:0])
                    
                    16'h2001: spi_dc_write_command(w_var1);
                    16'h2002: spi_dc_write_data(w_var1);
                    16'h2003: t_delay(w_var1);
                    16'h2004: t_led_state(w_var1[0]);
                    16'h2005: t_lcd_reset(w_var1[0]);
                    
                    16'h201?: spi_dc_write_command_reg;
                    16'h202?: spi_dc_data_command_reg;
                    16'h203?: t_delay_reg;
                     
                    16'h010?: t_set_reg(w_var1);       
                    16'h011?: t_inc_value_reg(w_var1);
                    16'h012?: t_dec_value_reg(w_var1);
                    16'h013?: t_compare_reg(w_var1);
                    16'h014?: t_inc_reg;
                    16'h015?: t_dec_reg;
                    16'h04??: t_copy_reg;
                    
                    16'b0000_0010_0000_00??: t_cond_zero_rel_jump(w_var1); // 0200 - 0203                    
                    16'b0000_0010_0000_01??: t_cond_equal_rel_jump(w_var1); // 0204 - 0207
                    
                    16'b0000_0010_0000_100?: t_cond_zero_jump(w_var1); // 0208 - 0209   
                    16'b0000_0010_0000_101?: t_cond_equal_jump(w_var1); // 020A - 020B   
                    16'h0210: t_jump(w_var1);
                    
                    16'h0300: t_stack_push_value(w_var1);
                    16'h031?: t_stack_push_reg;
                    16'h032?: t_stack_pop_reg;
                     
                
                    16'hFFFF: 
                    begin
                        r_SM_msg<=OPCODE_REQUEST;  
                        r_PC<=0;
                    end // Case FFFF                
                    default: 
                    begin
                        r_SM_msg<=HCF_1; // Halt and catch fire error 1 
                        r_error_code<=ERR_INV_OPCODE;
                    end // default case
                endcase //casez(w_opcode[15:0])
                end // case OPCODE_EXECUTE
                HCF_1:               
                begin
                    o_stack_write_flag<=1'b0;
                    o_stack_read_flag<=1'b0;
                    r_timeout_counter<=0;
                    r_SM_msg<=HCF_2;
                end
                HCF_2:  
                begin 
                    //r_seven_seg_value[31:8]<=24'h230C0F;  
                    //r_seven_seg_value[7:0]<=r_error_code;
                    r_seven_seg_value[31:0]<={4'h0,w_uart_rx_value[7:4],4'h0,w_uart_rx_value[3:0],4'h0,rx_count[7:4],4'h0,rx_count[3:0]};
                    r_timeout_max<=32'd100_000_000;
                    if(r_timeout_counter>=r_timeout_max)  
                    begin 
                        r_timeout_counter<=0;
                        r_SM_msg<=HCF_3;
                    end  // if(r_timeout_counter>=DELAY_TIME)
                    else
                    begin
                        r_timeout_counter<=r_timeout_counter+1;               
                    end // else if(r_timeout_counter>=DELAY_TIME)
                end
                HCF_3: 
                begin
                    r_timeout_counter<=0;
                    r_SM_msg<=HCF_4;
                end
                HCF_4:  
                begin 
                    //r_seven_seg_value<={4'h0,r_PC[15:12],4'h0,r_PC[11:8],4'h0,r_PC[7:4],4'h0,r_PC[3:0]};
                    r_timeout_max<=32'd100_000_000;
                    if(r_timeout_counter>=r_timeout_max)  
                    begin 
                        r_timeout_counter<=0;
                        r_SM_msg<=HCF_1;
                    end  // if(r_timeout_counter>=DELAY_TIME)
                    else
                    begin
                        r_timeout_counter<=r_timeout_counter+1;               
                    end // else if(r_timeout_counter>=DELAY_TIME)
                    
                end
                
           
                default: r_SM_msg<=HCF_1; // loop in error
            endcase // case(r_SM_msg)         
        end // else if (i_Rst_H)
    end // always @(posedge i_Clk)
    
endmodule