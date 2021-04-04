 // Set reg 
 // On completion
 // Increament PC 2
 // Increamaent r_SM_msg
 
// 8'h10 - set reg  value
// 8'h11 - inc reg  value 
// 8'h12 - dec reg  value
// 8'h13 - jump if  zero forwards
// 8'h14 - jump if  zero backwards
// 8'h15 - jump if  not zero forwards
// 8'h16 - jump if  not zero backwards


 // Copy from first reg to second
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
 // Increament r_SM_msg
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

// Compare register
// On completion
// Increament PC 2
// Increament r_SM_msg
 task t_compare_reg;
    input [15:0] i_value;  
    reg [3:0] reg_1; 
    begin
        reg_1=w_opcode[3:0];
        r_equal_flag <= r_register[reg_1]==i_value ? 1'b1 : 1'b0;
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2; 
    end
endtask 
