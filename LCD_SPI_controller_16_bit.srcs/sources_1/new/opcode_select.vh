// Can be read by assembler, so format is fixed. Opcode must be first word in comment. If opcode takes variable, it mst be passed as w_var1
task t_opcode_select;
begin
casez(w_opcode[15:0])
// SPI LCD Control 2xxx
                    16'h2001: spi_dc_write_command(w_var1);   // LCDCMDV
                    16'h2002: spi_dc_write_data(w_var1);      // LCDDATAV LCD data with value
                    16'h2003: t_delay(w_var1);                // DELAYV Set value   
                    16'h2005: t_lcd_reset(w_var1);            // LCD Reset line                     
                    16'h201?: spi_dc_write_command_reg;       // CDCDMR LCD command with register
                    16'h202?: spi_dc_data_command_reg;        // LCDDATAR LCD data with register
                    16'h203?: t_delay_reg;                    // DELAYR Delay with register
// Board LED and Switch 3xxx
                    16'h300?: t_led_reg;                      // LEDR set with register
                    16'h301?: t_get_switch_reg;               // SWR Get switch status into register
                    16'h302?: t_7_seg_reg;                    // 7SEGR Set 7 Seg to register
                    16'h3030: t_led_state(w_var1);            // LEDV Set LED value
                    16'h3031: t_7_seg_value(w_var1);          // 7SEGV Set 7 Seg to Value
                    
// Register control 0xxx
                    16'h01??: t_copy_regs;                    // COPY Copy register
                    16'h02??: t_and_regs;                     // AND AND register
                    16'h03??: t_or_regs;                      // OR OR register
                    16'h04??: t_xor_regs;                     // XOR XOR register
                    16'h05??: t_compare_regs;                 // CMPRR Compare registers
                    16'h06??: t_add_regs;                     // ADDRR Compare registers
                    16'h07??: t_minus_regs;                   // MINUSRR Compare registers                  
                    16'h080?: t_set_reg(w_var1);              // SETR Set register value
                    16'h081?: t_add_value(w_var1);            // ADDV Increament register by value
                    16'h082?: t_minus_value(w_var1);          // MINUSV Decreament register by value
                    16'h083?: t_compare_reg_value(w_var1);    // CMPRV Compare register to value
                    16'h084?: t_inc_reg;                      // INCR Increament register
                    16'h085?: t_dec_reg;                      // DECR Decreament register
                    16'h086?: t_and_reg_value(w_var1);        // ANDV AND register
                    16'h087?: t_or_reg_value(w_var1);         // ORV OR register with value
                    16'h088?: t_xor_reg_value(w_var1);        // XORV XOR register with value
                    16'h089?: t_set_reg_flags;                // SETFR Set register to flags value
                    16'h08A?: t_negate_reg;                   // NEGR Set register 2's comp
                                      
// Flow control 1xxx        
                    16'h1000: t_jump(w_var1);                    // JMP Jump
                    16'h1001: t_cond_zero_jump(w_var1);          // JMPZ Jump if zero 
                    16'h1002: t_cond_not_zero_jump(w_var1);      // JMPNZ Jump if not zero 
                    16'h1003: t_cond_equal_jump(w_var1);         // JMPE Jump if equal 
                    16'h1004: t_cond_not_equal_jump(w_var1);     // JMPNE Jump if not equal    
                    16'h1005: t_cond_carry_jump(w_var1);         // JMPC Jump if carry 
                    16'h1006: t_cond_not_carry_jump(w_var1);     // JMPNC Jump if not carry  
                    16'h1007: t_cond_overflow_jump(w_var1);      // JMPO Jump if overflow 
                    16'h1008: t_cond_not_overflow_jump(w_var1);  // JMPNO Jump if not overflow                                      
                    16'h1009: t_call(w_var1);                    // CALL Call function
                    16'h100A: t_cond_zero_call(w_var1);          // CALLZ Call if zero 
                    16'h100B: t_cond_not_zero_call(w_var1);      // CALLNZ Call if not zero 
                    16'h100C: t_cond_equal_call(w_var1);         // CALLE Call if equal 
                    16'h100D: t_cond_not_equal_call(w_var1);     // CALLNE Call if not equal    
                    16'h100E: t_cond_carry_call(w_var1);         // CALLC Call if carry 
                    16'h100F: t_cond_not_carry_call(w_var1);     // CALLNC Call if not carry  
                    16'h1010: t_cond_overflow_call(w_var1);      // CALLO Call if overflow 
                    16'h1011: t_cond_not_overflow_call(w_var1);  // CALLNO Call if not overflow             
                    16'h1012: t_ret;                             // RET Return from function               
                    
// Stack control 4xxx                
                    16'h400?: t_stack_push_reg;               // PUSH Push register onto stack
                    16'h401?: t_stack_pop_reg;                // POP Pop stack into register
                    16'h402?: t_stack_peek_reg;               // PEEK Peek stack into register 
                    16'h4030: t_stack_push_value(w_var1);     // PUSHV Push value onto stack            
// Other Fxxx
                    16'hF001: t_nop;                          // NOP No opperation
                    16'hF002: //                              // RESET Reset
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
 