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
                    16'h302?: t_7_seg_reg(w_var1);            // 7SEGR Set 7 Seg to register
                    16'h3030: t_led_state(w_var1);            // LEDV Set LED value
                    16'h3031: t_7_seg_value(w_var1);          // 7SEGV Set 7 Seg to Value
                    
// Register control 0xxx
                    16'h01??: t_copy_reg;                     // COPY Copy register
                    16'h02??: t_and_reg;                      // AND AND register
                    16'h03??: t_or_reg;                       // OR OR register
                    16'h04??: t_xor_reg;                      // XOR XOR register
                    16'h05??: t_compare_regs;                 // CMPRR Compare registers
                    16'h060?: t_set_reg(w_var1);              // SETR Set register value
                    16'h061?: t_inc_value_reg(w_var1);        // INCRV Increament register by value
                    16'h062?: t_dec_value_reg(w_var1);        // DECRV Decreament register by value
                    16'h063?: t_compare_reg_value(w_var1);    // CMPRV Compare register to value
                    16'h064?: t_inc_reg;                      // INCR Increament register
                    16'h065?: t_dec_reg;                      // DECR Decreament register
                    16'h066?: t_and_reg_value(w_var1);        // ANDV AND register
                    16'h067?: t_or_reg_value(w_var1);         // ORV OR register
                    16'h068?: t_xor_reg_value(w_var1);        // XORV XORV register
                    
// Flow control 1xxx        
                    16'h1000: t_cond_zero_jump(w_var1);       // JMPZ Jump if zero 
                    16'h1001: t_cond_not_zero_jump(w_var1);   // JMPNZ Jump if not zero 
                    16'h1002: t_cond_equal_jump(w_var1);      // JMPE Jump if equal 
                    16'h1003: t_cond_not_equal_jump(w_var1);  // JMPNE Jump not if equal                         
                    16'h1004: t_call(w_var1);                 // CALL Call function
                    16'h1005: t_ret;                          // RET Return from function               
                    16'h1006: t_jump(w_var1);                 // JMP Jump
// Stack control 4xxx                
                    16'h400?: t_stack_push_reg;               // PUSH Push register onto stack
                    16'h401?: t_stack_pop_reg;                // POP Pop stack into register
                    16'h402?: t_stack_peek_reg;               // PEEK Peek stack into register 
                    16'h4030: t_stack_push_value(w_var1);     // PUSHV Push value onto stack            
// Other Fxxx
                    16'hF001: t_nop;                          // NOP No opperation
                    16'hF002:                                 // RESET Reset
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
 