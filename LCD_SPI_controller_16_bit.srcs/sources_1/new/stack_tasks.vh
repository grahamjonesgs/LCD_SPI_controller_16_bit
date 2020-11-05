// Push value onto stack
 // On completion
 // Increament PC 2
 // Increament r_SM_msg
task t_stack_push_value;
    input [15:0] i_value;
    begin
        o_stack_write_value<=i_value;
        o_stack_write_flag<=1'b1;
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
        o_stack_write_flag<=1'b1;
        r_SM_msg<=OPCODE_REQUEST;  
        r_PC<=r_PC+1; 
        case(w_opcode[3:0])
        0: o_stack_write_value <= r_register[0];
        1: o_stack_write_value <= r_register[1];
        2: o_stack_write_value <= r_register[2];
        3: o_stack_write_value <= r_register[3];
        4: o_stack_write_value <= r_register[4];
        5: o_stack_write_value <= r_register[5];
        6: o_stack_write_value <= r_register[6];
        7: o_stack_write_value <= r_register[7];
        default: ; 
        endcase        
    end
endtask

// Push register onto stack
 // On completion
 // Increament PC
 // Increament r_SM_msg
task t_stack_pop_reg;
    begin
    case(w_opcode[3:0])
                0: r_register[0] <= o_stack_read_flag;
                1: r_register[1] <= o_stack_read_flag;
                2: r_register[2] <= o_stack_read_flag;
                3: r_register[3] <= o_stack_read_flag;
                4: r_register[4] <= o_stack_read_flag;
                5: r_register[5] <= o_stack_read_flag;
                6: r_register[6] <= o_stack_read_flag;
                7: r_register[7] <= o_stack_read_flag;
                default: ; 
     endcase  
     o_stack_read_flag<=1'b1;
     r_SM_msg<=OPCODE_REQUEST;  
     r_PC<=r_PC+1;  
     end
endtask  