// Push value onto stack
 // On completion
 // Increament PC 2
 // Increament r_SM_msg
task t_stack_push_value;
    input [15:0] i_value;
    begin
        r_stack_write_value<=i_value;
        r_stack_write_flag<=1'b1; // to move stack pointer
        r_SM_msg<=OPCODE_REQUEST;  
        r_PC<=r_PC+2;    
    end
endtask 

// Push register onto stack
 // On completion
 // Increament PC
 // Increament r_SM_msg
task t_stack_push_reg;
    begin
        r_stack_write_flag<=1'b1;  // to move stack pointer
        r_SM_msg<=OPCODE_REQUEST;  
        r_PC<=r_PC+1; 
        case(w_opcode[3:0])
        0: r_stack_write_value <= r_register[0];
        1: r_stack_write_value <= r_register[1];
        2: r_stack_write_value <= r_register[2];
        3: r_stack_write_value <= r_register[3];
        4: r_stack_write_value <= r_register[4];
        5: r_stack_write_value <= r_register[5];
        6: r_stack_write_value <= r_register[6];
        7: r_stack_write_value <= r_register[7];
        default: ; 
        endcase        
    end
endtask

// Pop register from stack
 // On completion
 // Increament PC 
 // Increament r_SM_msg
task t_stack_pop_reg;
    begin
    case(w_opcode[3:0])
                0: r_register[0] <= i_stack_top_value;
                1: r_register[1] <= i_stack_top_value;
                2: r_register[2] <= i_stack_top_value;
                3: r_register[3] <= i_stack_top_value;
                4: r_register[4] <= i_stack_top_value;
                5: r_register[5] <= i_stack_top_value;
                6: r_register[6] <= i_stack_top_value;
                7: r_register[7] <= i_stack_top_value;
                default: ; 
     endcase  
     r_stack_read_flag<=1'b1; // to move stack pointer
     r_SM_msg<=OPCODE_REQUEST;  
     r_PC<=r_PC+1;  
     end
endtask  


 ila_0  myila2(.clk(i_Clk),
 .probe0(w_opcode),
 .probe1(r_check_number),
 .probe2(r_PC),
 .probe3(i_stack_peek_value),
 .probe4(r_register[0]),
 .probe5(w_var1),
 .probe6(r_SM_msg),
 .probe7(r_register[0]),
 .probe8(o_SPI_LCD_Clk),
 .probe9(i_SPI_LCD_MISO),
 .probe10(o_SPI_LCD_MOSI),
 .probe11(o_SPI_LCD_CS_n),
 .probe12(o_LCD_DC),
 .probe13(o_LCD_reset_n),
 .probe14(r_zero_flag),
 .probe15(1'b0));
// Pop register from stack
 // On completion
 // Increament PC 2
 // Increament r_SM_msg
task t_stack_peek_reg;
    begin
        if (r_extra_cycle==0)
        begin
            r_extra_cycle<=1;
        end //if (r_extra_cycle==0)
        else
        begin
            case(w_opcode[3:0])
                0: r_register[0] <= i_stack_peek_value;
                1: r_register[1] <= i_stack_peek_value;
                2: r_register[2] <= i_stack_peek_value;
                3: r_register[3] <= i_stack_peek_value;
                4: r_register[4] <= i_stack_peek_value;
                5: r_register[5] <= i_stack_peek_value;
                6: r_register[6] <= i_stack_peek_value;
                7: r_register[7] <= i_stack_peek_value;
                default: ; 
            endcase  
            r_SM_msg<=OPCODE_REQUEST;  
            r_PC<=r_PC+2; 
            r_extra_cycle<=0; 
        end // else if (r_extra_cycle==0)
     end
endtask  