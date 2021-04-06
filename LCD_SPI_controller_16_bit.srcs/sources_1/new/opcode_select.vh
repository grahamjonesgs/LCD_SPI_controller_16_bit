// Can be read by assembler, so format is fixed. Opcode must be first word in comment. If opcode takes variable, it mst be passed as w_var1
task t_opcode_select;
begin
casez(w_opcode[15:0])
                    16'h2001: spi_dc_write_command(w_var1); // LCDCMDV
                    16'h2002: spi_dc_write_data(w_var1);    // LCDDATAV LCD data with value
                    16'h2003: t_delay(w_var1);              // DELAYV Set value
                    16'h2004: t_led_state(w_var1);          // LEDV Set LED value
                    16'h2005: t_lcd_reset(w_var1);          // LCD Reset line
                        
                    16'h201?: spi_dc_write_command_reg;     // CDCDMR LCD command with register
                    16'h202?: spi_dc_data_command_reg;      // LCDDATAR LCD data with register
                    16'h203?: t_delay_reg;                  // DELAYR Delay with register
                    16'h204?: t_led_reg;                    // LEDR set with register
                    16'h205?: t_get_switch_reg;             // SWR Get switch status into register

                    16'h010?: t_set_reg(w_var1);            // SETR Set register value
                    16'h011?: t_inc_value_reg(w_var1);      // INCRV Increament register by value
                    16'h012?: t_dec_value_reg(w_var1);      // DECRV Decreament register by value
                    16'h013?: t_compare_reg_value(w_var1);  // CMPRV Compare register to value
                    16'h014?: t_inc_reg;                    // INCR Increament register
                    16'h015?: t_dec_reg;                    // DECR Decreament register
                    16'h04??: t_copy_reg;                   // COPY Copy register
                    16'h05??: t_and_reg;                    // AND AND register
                    16'h06??: t_or_reg;                     // OR OR register
                    16'h07??: t_xor_reg;                    // XOR XOR register
                    16'h080?: t_and_reg_value(w_var1);      // ANDV AND register
                    16'h081?: t_or_reg_value(w_var1);       // ORV OR register
                    16'h082?: t_xor_reg_value(w_var1);      // XORV XORV register
                    16'h09??: t_compare_regs;               // CMPRR Compare registers
                    
                    16'h0208:  t_cond_zero_jump(w_var1);    // JMPZ Jump if zero 
                    16'h0209:  t_cond_not_zero_jump(w_var1);// JMPZ Jump if not zero 
                    16'h020A:  t_cond_equal_jump(w_var1);   // JMPE Jump if equal 
                    16'h020B:  t_cond_not_equal_jump(w_var1);// JMPNE Jump not if equal 
                    
                    
                    
                        
                    16'h020C: t_call(w_var1);               // CALL Call function
                    16'h020D: t_ret;                        // RET Return from function
                    16'h020E: t_nop;                        // NOP No opperation
                    16'h0210: t_jump(w_var1);               // JMP Jump

                    16'h0300: t_stack_push_value(w_var1);  // PUSHV Push value onto stack
                    16'h031?: t_stack_push_reg;            // PUSH Push register onto stack
                    16'h032?: t_stack_pop_reg;             // POP Pop stack into register
                    16'h033?: t_stack_peek_reg;            // PEEK Peek stack into register
                    
                    16'h2100: t_7_seg_value(w_var1);       // 7SEGV Set 7 Seg to Value
                    16'h211?: _7_seg_reg(w_var1);          // 7SEGR Set 7 Seg to register
                    16'hFFFF:                              // RESET Reset
                    begin
                        r_SM<=OPCODE_REQUEST;
                        r_PC<=12'h0;
                    end // Case FFFF
                    default:
                    begin
                        r_SM<=HCF_1; // Halt and catch fire error 1
                        r_error_code<=ERR_INV_OPCODE;
                    end // default case
                endcase //casez(w_opcode[15:0])
    end
endtask
 