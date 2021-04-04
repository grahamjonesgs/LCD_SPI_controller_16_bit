
// Jump if zero condition met jump relative as per opcode direction
// On completion
// Increament PC  2 or jump twice amount
// Increament r_SM
// 0200 Jump if zero forwards
// 0201 Jump if zero backwards
// 0202 Jump if not zero forwards
// 0203 Jump if not zero backwards
 task t_cond_zero_rel_jump;
    input [15:0] i_value;  
    begin  
        if(r_zero_flag!=w_opcode[1])  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=w_opcode[1]?r_PC+i_value : r_PC-i_value; // jump based on direction bit
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask

// Jump if equal condition met jump relative as per opcode direction
// On completion
// Increament PC  2 or jump twice amount
// Increament r_SM
// 0204 Jump if equal forwards
// 0205 Jump if equal backwards
// 0206 Jump if not equal forwards
// 0207 Jump if not equal backwards
 task t_cond_equal_rel_jump;
    input [15:0] i_value;  
    begin
        if(r_equal_flag!=w_opcode[1])  // if zero flag  equal to request
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=w_opcode[1]?r_PC+i_value : r_PC-i_value; // jump based on direction bit
        end // if(r_register_a==8'h0)
        else
        begin
            r_SM<=OPCODE_REQUEST;  
            r_PC<=r_PC+2;
        end // else if(r_register_a==8'h0)    
    end
endtask     
 
 
// Jump if zero condition met
// On completion
// Increament PC  2 or jump
// Increament r_SM
// 0208 Jump if zero
// 0209 Jump if not zero
 task t_cond_zero_jump;
    input [15:0] i_value; 
    begin
        if(r_zero_flag!=w_opcode[1])  // if zero flag  equal to request
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
// Increament PC  2 or jump
// Increament r_SM
// 020A Jump if zero
// 020B Jump if not zero
 task t_cond_equal_jump;
    input [15:0] i_value; 
    begin
        if(r_equal_flag!=w_opcode[1])  // if zero flag  equal to request
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
// Increament PC  2 or jump
// Increament r_SM
 task t_jump;
    input [15:0] i_value; 
    begin
       r_SM<=OPCODE_REQUEST;  
       r_PC<=i_value;    
    end
endtask       
 
