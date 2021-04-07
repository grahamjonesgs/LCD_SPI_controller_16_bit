// Jump if zero condition met
// On completion
// Increment PC  2 or jump
// Increment r_SM
 task t_cond_zero_jump;
    input [15:0] i_value; 
    begin
        if(r_zero_flag)  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; // jump
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask 

// Jump if zero not condition met
// On completion
// Increment PC  2 or jump
// Increment r_SM
 task t_cond_not_zero_jump;
    input [15:0] i_value; 
    begin
        if(!r_zero_flag)  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; // jump
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask 

// Jump if equal condition met
// On completion
// Increment PC  2 or jump
// Increment r_SM
 task t_cond_equal_jump;
    input [15:0] i_value; 
    begin
        if(r_equal_flag)  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; // jump
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask  

// Jump if equal not condition met
// On completion
// Increment PC  2 or jump
// Increment r_SM
 task t_cond_not_equal_jump;
    input [15:0] i_value; 
    begin
        if(!r_equal_flag)  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; // jump
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask  

// Jump if carry condition met
// On completion
// Increment PC  2 or jump
// Increment r_SM
 task t_cond_carry_jump;
    input [15:0] i_value; 
    begin
        if(r_carry_flag)  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; // jump
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask  

// Jump if carry not condition met
// On completion
// Increment PC  2 or jump
// Increment r_SM
 task t_cond_not_carry_jump;
    input [15:0] i_value; 
    begin
        if(!r_carry_flag)  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; // jump
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask  

// Jump if overflow condition met
// On completion
// Increment PC  2 or jump
// Increment r_SM
 task t_cond_overflow_jump;
    input [15:0] i_value; 
    begin
        if(r_overflow_flag)  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; // jump
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask  

// Jump if overflow not condition met
// On completion
// Increment PC  2 or jump
// Increment r_SM
 task t_cond_not_overflow_jump;
    input [15:0] i_value; 
    begin
        if(!r_overflow_flag)  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; // jump
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask  



// Jump
// On completion
// PC  set to value
// Increment r_SM
 task t_jump;
    input [15:0] i_value; 
    begin
       r_SM<=OPCODE_REQUEST;  
       r_PC<=i_value;    
    end
endtask       

// Call - push PC on stack 
// On completion
// PC  set to value
// Increment r_SM 
task t_call;
    input [15:0] i_value; 
    begin
       r_stack_write_value=r_PC;   // push PC on stack
       r_stack_write_flag<=1'b1;   // to move stack pointer
       r_SM<=OPCODE_REQUEST;  
       r_PC<=i_value;    
    end
endtask  

// Call if zero - push PC on stack 
// On completion
// PC  set to value, or increment by 2
// Increment r_SM 
task t_cond_zero_call;
    input [15:0] i_value; 
    begin
        if(r_zero_flag)  // if zero flag  equal to request
        begin
            r_stack_write_value=r_PC;   // push PC on stack
            r_stack_write_flag<=1'b1;   // to move stack pointer
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; 
        end
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
       end   
    end
endtask 

// Call if not zero - push PC on stack 
// On completion
// PC  set to value, or increment by 2
// Increment r_SM 
task t_cond_not_zero_call;
    input [15:0] i_value; 
    begin
        if(!r_zero_flag)  // if zero flag  equal to request
        begin
            r_stack_write_value=r_PC;   // push PC on stack
            r_stack_write_flag<=1'b1;   // to move stack pointer
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; 
        end
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
       end   
    end
endtask 

// Call if equal - push PC on stack 
// On completion
// PC  set to value, or increment by 2
// Increment r_SM 
task t_cond_equal_call;
    input [15:0] i_value; 
    begin
        if(r_equal_flag)  // if zero flag  equal to request
        begin
            r_stack_write_value=r_PC;   // push PC on stack
            r_stack_write_flag<=1'b1;   // to move stack pointer
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; 
        end
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
       end   
    end
endtask 

// Call if not equal - push PC on stack 
// On completion
// PC  set to value, or increment by 2
// Increment r_SM 
task t_cond_not_equal_call;
    input [15:0] i_value; 
    begin
        if(!r_equal_flag)  // if zero flag  equal to request
        begin
            r_stack_write_value=r_PC;   // push PC on stack
            r_stack_write_flag<=1'b1;   // to move stack pointer
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; 
        end
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
       end   
    end
endtask 

// Call if carry - push PC on stack 
// On completion
// PC  set to value, or increment by 2
// Increment r_SM 
task t_cond_carry_call;
    input [15:0] i_value; 
    begin
        if(r_carry_flag)  // if zero flag  equal to request
        begin
            r_stack_write_value=r_PC;   // push PC on stack
            r_stack_write_flag<=1'b1;   // to move stack pointer
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; 
        end
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
       end   
    end
endtask 

// Call if not carry - push PC on stack 
// On completion
// PC  set to value, or increment by 2
// Increment r_SM 
task t_cond_not_carry_call;
    input [15:0] i_value; 
    begin
        if(!r_carry_flag)  // if zero flag  equal to request
        begin
            r_stack_write_value=r_PC;   // push PC on stack
            r_stack_write_flag<=1'b1;   // to move stack pointer
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; 
        end
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
       end   
    end
endtask 

// Call if overflow - push PC on stack 
// On completion
// PC  set to value, or increment by 2
// Increment r_SM 
task t_cond_overflow_call;
    input [15:0] i_value; 
    begin
        if(r_overflow_flag)  // if zero flag  equal to request
        begin
            r_stack_write_value=r_PC;   // push PC on stack
            r_stack_write_flag<=1'b1;   // to move stack pointer
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; 
        end
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
       end   
    end
endtask 

// Call if not overflow - push PC on stack 
// On completion
// PC  set to value, or increment by 2
// Increment r_SM 
task t_cond_not_overflow_call;
    input [15:0] i_value; 
    begin
        if(!r_overflow_flag)  // if zero flag  equal to request
        begin
            r_stack_write_value=r_PC;   // push PC on stack
            r_stack_write_flag<=1'b1;   // to move stack pointer
            r_SM<=OPCODE_REQUEST;  
            r_PC<=i_value; 
        end
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
       end   
    end
endtask 


// Return from call, pop new pc from stack 
// On completion
// PC  set to top of stack +2
// Increment r_SM 
task t_ret; 
    begin
       r_stack_read_flag<=1'b1;  // to move stack pointer
       r_SM<=OPCODE_REQUEST;     // Pop PC from stack plus 2 to jump over call
       r_PC<=i_stack_top_value+2;    
    end
endtask 

// Do nothng 
// On completion
// Increment PC
// Increment r_SM 
task t_nop; 
    begin
       r_SM<=OPCODE_REQUEST;     // Pop PC from stack plus 2 to jump over call
       r_PC<=+1;    
    end
endtask   
