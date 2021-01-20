 // SPI Write to LCD as command
 // On completion
 // Increament PC 2
 // Increamaent r_SM
 task spi_dc_write_command;
    input [15:0] i_byte; 
    begin
    if (i_TX_LCD_Ready)
        begin
            o_TX_LCD_Byte<=i_byte[7:0];
            o_LCD_DC<=0;
            o_TX_LCD_DV<=1'b1;
            r_timeout_counter<=0;
            r_SM<=OPCODE_REQUEST;
            r_PC<=r_PC+2;
        end // if (i_TX_Ready)
        else
        begin
            o_TX_LCD_DV<=1'b0;    
        end // else if (i_TX_Ready)
    end
endtask
    
 // SPI Write to LCD as data
 // On completion
 // Increament PC 2
 // Increamaent r_SM   
task spi_dc_write_data;
    input [15:0] i_byte; 
    begin
    if (i_TX_LCD_Ready)
        begin
            o_TX_LCD_Byte<=i_byte[7:0];
            o_LCD_DC<=1;
            o_TX_LCD_DV<=1'b1;
            r_timeout_counter<=0;
            r_SM<=OPCODE_REQUEST;
            r_PC<=r_PC+2;
        end // if (i_TX_Ready)
        else
        begin
            o_TX_LCD_DV<=1'b0;    
        end // else if (i_TX_Ready)
    end
endtask

 // SPI Write command to LCD as from lower byte of register
 // On completion
 // Increament PC 1
 // Increamaent r_SM 

task spi_dc_write_command_reg;
   reg [7:0] r_temp_value;
    begin
    case(w_opcode[3:0]) //Block assignment
        0: r_temp_value=r_register[0][7:0];
        1: r_temp_value=r_register[1][7:0];
        2: r_temp_value=r_register[2][7:0];
        3: r_temp_value=r_register[3][7:0];
        4: r_temp_value=r_register[4][7:0];
        5: r_temp_value=r_register[5][7:0];
        6: r_temp_value=r_register[6][7:0];
        7: r_temp_value=r_register[7][7:0];     
        default:r_temp_value=8'h0 ;
    endcase
    if (i_TX_LCD_Ready)
        begin
            o_TX_LCD_Byte<=r_temp_value;
            o_LCD_DC<=0;
            o_TX_LCD_DV<=1'b1;
            r_timeout_counter<=0;
            r_SM<=OPCODE_REQUEST;
            r_PC<=r_PC+1;
        end // if (i_TX_Ready)
        else
        begin
            o_TX_LCD_DV<=1'b0;    
        end // else if (i_TX_Ready)
    end
endtask

 // SPI Write data to LCD as from lower byte of register
 // On completion
 // Increament PC 1
 // Increamaent r_SM 


task spi_dc_data_command_reg;
   reg [7:0] r_temp_value;
    begin
    case(w_opcode[3:0]) //Block assignment
        0: r_temp_value=r_register[0][7:0];
        1: r_temp_value=r_register[1][7:0];
        2: r_temp_value=r_register[2][7:0];
        3: r_temp_value=r_register[3][7:0];
        4: r_temp_value=r_register[4][7:0];
        5: r_temp_value=r_register[5][7:0];
        6: r_temp_value=r_register[6][7:0];
        7: r_temp_value=r_register[7][7:0];     
        default:r_temp_value=8'h0 ;
    endcase
    if (i_TX_LCD_Ready)
        begin
            o_TX_LCD_Byte<=r_temp_value;
            o_LCD_DC<=1;
            o_TX_LCD_DV<=1'b1;
            r_timeout_counter<=0;
            r_SM<=OPCODE_REQUEST;
            r_PC<=r_PC+1;
        end // if (i_TX_Ready)
        else
        begin
            o_TX_LCD_DV<=1'b0;    
        end // else if (i_TX_Ready)
    end
endtask
    

    
 // Set LCD Reset value signal status
 // On completion
 // Increament PC
 // Increamaent r_SM
   
task t_lcd_reset;
    input i_state; 
    begin
        o_LCD_reset_n<=i_state;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2;    
    end
endtask