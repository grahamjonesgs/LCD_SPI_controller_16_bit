// Copy from second reg to first
// On completion
// Increament PC
// Increament r_SM_msg
task t_copy_reg;
    reg [3:0] reg_1;
    reg [3:0] reg_2;
    begin
        reg_2=w_opcode[3:0];
        reg_1=w_opcode[11:8];
        r_register[reg_1]<=r_register[reg_2];
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1;    
    end
endtask 

// AND first reg with second, result in first
// On completion
// Increament PC
// Increament r_SM_msg
task t_and_reg;
    reg [3:0] reg_1;
    reg [3:0] reg_2;
    begin
        reg_2=w_opcode[3:0];
        reg_1=w_opcode[11:8];
        r_register[reg_1]<=r_register[reg_1]&r_register[reg_2];
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1;    
    end
endtask 

// OR first reg with second, result in first
// On completion
// Increament PC
// Increament r_SM_msg
task t_or_reg;
    reg [3:0] reg_1;
    reg [3:0] reg_2;
    begin
        reg_2=w_opcode[3:0];
        reg_1=w_opcode[11:8];
        r_register[reg_1]<=r_register[reg_1]|r_register[reg_2];
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1;    
    end
endtask 

// XOR first reg with second, result in first
// On completion
// Increament PC
// Increament r_SM_msg
task t_xor_reg;
    reg [3:0] reg_1;
    reg [3:0] reg_2;
    begin
        reg_2=w_opcode[3:0];
        reg_1=w_opcode[11:8];
        r_register[reg_1]<=r_register[reg_1]^r_register[reg_2];
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1;    
    end
endtask 

// AND first reg with value, result in first
// On completion
// Increament PC by 2
// Increament r_SM_msg
task t_and_reg_value;
    input [15:0] i_value;
    reg [3:0] reg_1;
    begin
        reg_1=w_opcode[3:0];
        r_register[reg_1]<=r_register[reg_1]&i_value;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2;    
    end
endtask 

// OR first reg with value, result in first
// On completion
// Increament PC by 2
// Increament r_SM_msg
task t_or_reg_value;
    input [15:0] i_value;
    reg [3:0] reg_1;
    begin
        reg_1=w_opcode[3:0];
        r_register[reg_1]<=r_register[reg_1]|i_value;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2;    
    end
endtask 

// XOR first reg with value, result in first
// On completion
// Increament PC by 2
// Increament r_SM_msg
task t_xor_reg_value;
    input [15:0] i_value;
    reg [3:0] reg_1;
    begin
        reg_1=w_opcode[3:0];
        r_register[reg_1]<=r_register[reg_1]^i_value;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2;    
    end
endtask 

// Set reg with value
// On completion
// Increament PC 2
// Increament r_SM_msg
task t_set_reg;
    input [15:0] i_value; 
    reg [3:0] reg_1;
    begin
        reg_1=w_opcode[3:0];
        r_register[reg_1]<=i_value;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2;    
    end
endtask 
 
 // Inc reg by value
 // On completion
 // Increament PC 2
 // Increament r_SM_msg
 task t_inc_value_reg;
    input [15:0] i_value; 
    reg [3:0] reg_1; 
    begin
        reg_1=w_opcode[3:0];
        r_register[reg_1]<=r_register[reg_1]+i_value;
        r_zero_flag <= r_register[reg_1]+i_value==0 ? 1'b1 : 1'b0;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2; 
    end
endtask 

// Dec reg by value
// On completion
// Increament PC 2
// Increament r_SM_msg
 task t_dec_value_reg;
    input [15:0] i_value; 
    reg [3:0] reg_1; 
    begin
        reg_1=w_opcode[3:0];
        r_register[reg_1]<=r_register[reg_1]-i_value;
        r_zero_flag <= r_register[reg_1]-i_value==0 ? 1'b1 : 1'b0;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2; 
    end
endtask 
  
// Dec reg
// On completion
// Increament PC
// Increament r_SM_msg
task t_dec_reg;  
    reg [3:0] reg_1; 
    begin
        reg_1=w_opcode[3:0];
        r_register[reg_1]<=r_register[reg_1]-1;
        r_zero_flag <= r_register[reg_1]-1==0 ? 1'b1 : 1'b0;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1; 
    end
endtask 

// Inc reg
// On completion
// Increament PC
// Increment r_SM_msg
task t_inc_reg;  
    reg [3:0] reg_1; 
    begin
        reg_1=w_opcode[3:0];
        r_register[reg_1]<=r_register[reg_1]+1;
        r_zero_flag <= r_register[reg_1]+1==0 ? 1'b1 : 1'b0;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1; 
    end
endtask 

// Compare register to value
// On completion
// Increment PC 2
// Increment r_SM_msg
 task t_compare_reg_value;
    input [15:0] i_value;  
    reg [3:0] reg_1; 
    begin
        reg_1=w_opcode[3:0];
        r_equal_flag <= r_register[reg_1]==i_value ? 1'b1 : 1'b0;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2; 
    end
endtask 


// Compare registers
// On completion
// Increment PC 2
// Increment r_SM_msg
 task t_compare_regs;  
    reg [3:0] reg_1; 
    reg [3:0] reg_2;
    begin
        reg_2=w_opcode[3:0];
        reg_1=w_opcode[11:8];
        r_equal_flag <= r_register[reg_1]==r_register[reg_2] ? 1'b1 : 1'b0;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2; 
    end
endtask 
