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
    reg [15:0] r_temp_register;
    begin
        case(w_opcode[11:8]) //Block assignment
            0: r_temp_register=r_register[0];
            1: r_temp_register=r_register[1];
            2: r_temp_register=r_register[2];
            3: r_temp_register=r_register[3];
            4: r_temp_register=r_register[4];
            5: r_temp_register=r_register[5];
            6: r_temp_register=r_register[6];
            7: r_temp_register=r_register[7];     
            default:r_temp_register=8'h0 ;
        endcase
        case(w_opcode[3:0])
            0: r_temp_register=r_register[0]<=r_temp_register;
            1: r_temp_register=r_register[1]<=r_temp_register;
            2: r_temp_register=r_register[2]<=r_temp_register;
            3: r_temp_register=r_register[3]<=r_temp_register;
            4: r_temp_register=r_register[4]<=r_temp_register;
            5: r_temp_register=r_register[5]<=r_temp_register;
            6: r_temp_register=r_register[6]<=r_temp_register;
            7: r_temp_register=r_register[7]<=r_temp_register;
            default: ;
        endcase
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1;    
    end
endtask 

 // Set reg with value
 // On completion
 // Increament PC 2
 // Increament r_SM_msg
task t_set_reg;
    input [15:0] i_value; 
    begin
        case(w_opcode[3:0])
            0: r_register[0]<=i_value;
            1: r_register[1]<=i_value;
            2: r_register[2]<=i_value;
            3: r_register[3]<=i_value;
            4: r_register[4]<=i_value;
            5: r_register[5]<=i_value;
            6: r_register[6]<=i_value;
            7: r_register[7]<=i_value;
            default: ;
        endcase
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
    begin
        case(w_opcode[3:0])
        0:
        begin
            r_register[0]<=r_register[0]+i_value;
            r_zero_flag = r_register[0]+i_value==0 ? 1'b1 : 1'b0;
        end
        1:
        begin
            r_register[1]<=r_register[1]+i_value;
            r_zero_flag = r_register[1]+i_value==0 ? 1'b1 : 1'b0;
        end
        2:
        begin
            r_register[2]<=r_register[2]+i_value;
            r_zero_flag = r_register[2]+i_value==0 ? 1'b1 : 1'b0;
        end
        3:
        begin
            r_register[3]<=r_register[3]+i_value;
            r_zero_flag = r_register[3]+i_value==0 ? 1'b1 : 1'b0;
        end
        4:
        begin
            r_register[4]<=r_register[4]+i_value;
            r_zero_flag = r_register[4]+i_value==0 ? 1'b1 : 1'b0;
        end
        5:
        begin
            r_register[5]<=r_register[5]+i_value;
            r_zero_flag = r_register[5]+i_value==0 ? 1'b1 : 1'b0;
        end
        6:
        begin
            r_register[6]<=r_register[6]+i_value;
            r_zero_flag = r_register[6]+i_value==0 ? 1'b1 : 1'b0;
        end
        7:
        begin
            r_register[7]<=r_register[7]+i_value;
            r_zero_flag = r_register[7]+i_value==0 ? 1'b1 : 1'b0;
        end
        default: ; 
        endcase  
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
    begin
        case(w_opcode[3:0])
        0:
        begin
            r_register[0]<=r_register[0]-i_value;
            r_zero_flag = r_register[0]-i_value==0 ? 1'b1 : 1'b0;
        end
        1:
        begin
            r_register[1]<=r_register[1]-i_value;
            r_zero_flag = r_register[1]-i_value==0 ? 1'b1 : 1'b0;
        end
        2:
        begin
            r_register[2]<=r_register[2]-i_value;
            r_zero_flag = r_register[2]-i_value==0 ? 1'b1 : 1'b0;
        end
        3:
        begin
            r_register[3]<=r_register[3]-i_value;
            r_zero_flag = r_register[3]-i_value==0 ? 1'b1 : 1'b0;
        end
        4:
        begin
            r_register[4]<=r_register[4]-i_value;
            r_zero_flag = r_register[4]-i_value==0 ? 1'b1 : 1'b0;
        end
        5:
        begin
            r_register[5]<=r_register[5]-i_value;
            r_zero_flag = r_register[5]-i_value==0 ? 1'b1 : 1'b0;
        end
        6:
        begin
            r_register[6]<=r_register[6]-i_value;
            r_zero_flag = r_register[6]-i_value==0 ? 1'b1 : 1'b0;
        end
        7:
        begin
            r_register[7]<=r_register[7]-i_value;
            r_zero_flag = r_register[7]-i_value==0 ? 1'b1 : 1'b0;
        end
        default: ; 
        endcase  
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2; 
    end
endtask 

// Inc reg
 // On completion
 // Increament PC
 // Increament r_SM_msg
 task t_inc_reg;  
    begin
        case(w_opcode[3:0])
        0:
        begin
            r_register[0]<=r_register[0]+1;
            r_zero_flag = r_register[0]+1==0 ? 1'b1 : 1'b0;
        end
        1:
        begin
            r_register[1]<=r_register[1]+1;
            r_zero_flag = r_register[1]+1==0 ? 1'b1 : 1'b0;
        end
        2:
        begin
            r_register[2]<=r_register[2]+1;
            r_zero_flag = r_register[2]+1==0 ? 1'b1 : 1'b0;
        end
        3:
        begin
            r_register[3]<=r_register[3]+1;
            r_zero_flag = r_register[3]+1==0 ? 1'b1 : 1'b0;
        end
        4:
        begin
            r_register[4]<=r_register[4]+1;
            r_zero_flag = r_register[4]+1==0 ? 1'b1 : 1'b0;
        end
        5:
        begin
            r_register[5]<=r_register[5]+1;
            r_zero_flag = r_register[5]+1==0 ? 1'b1 : 1'b0;
        end
        6:
        begin
            r_register[6]<=r_register[6]+1;
            r_zero_flag = r_register[6]+1==0 ? 1'b1 : 1'b0;
        end
        7:
        begin
            r_register[7]<=r_register[7]+1;
            r_zero_flag = r_register[7]+1==0 ? 1'b1 : 1'b0;
        end
        default: ; 
        endcase  
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1; 
    end
endtask 

// Dec reg
 // On completion
 // Increament PC
 // Increament r_SM_msg
 task t_dec_reg;  
    begin
        case(w_opcode[3:0])
        0:
        begin
            r_register[0]<=r_register[0]-1;
            r_zero_flag = r_register[0]-1==0 ? 1'b1 : 1'b0;
        end
        1:
        begin
            r_register[1]<=r_register[1]-1;
            r_zero_flag = r_register[1]-1==0 ? 1'b1 : 1'b0;
        end
        2:
        begin
            r_register[2]<=r_register[2]-1;
            r_zero_flag = r_register[2]-1==0 ? 1'b1 : 1'b0;
        end
        3:
        begin
            r_register[3]<=r_register[3]-1;
            r_zero_flag = r_register[3]-1==0 ? 1'b1 : 1'b0;
        end
        4:
        begin
            r_register[4]<=r_register[4]-1;
            r_zero_flag = r_register[4]-1==0 ? 1'b1 : 1'b0;
        end
        5:
        begin
            r_register[5]<=r_register[5]-1;
            r_zero_flag = r_register[5]-1==0 ? 1'b1 : 1'b0;
        end
        6:
        begin
            r_register[6]<=r_register[6]-1;
            r_zero_flag = r_register[6]-1==0 ? 1'b1 : 1'b0;
        end
        7:
        begin
            r_register[7]<=r_register[7]-1;
            r_zero_flag = r_register[7]-1==0 ? 1'b1 : 1'b0;
        end
        default: ; 
        endcase  
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
    begin
        case(w_opcode[3:0])
        0: r_equal_flag <= r_register[0]==i_value ? 1'b1 : 1'b0;
        1: r_equal_flag <= r_register[1]==i_value ? 1'b1 : 1'b0;
        2: r_equal_flag <= r_register[2]==i_value ? 1'b1 : 1'b0;
        3: r_equal_flag <= r_register[3]==i_value ? 1'b1 : 1'b0;
        4: r_equal_flag <= r_register[4]==i_value ? 1'b1 : 1'b0;
        5: r_equal_flag <= r_register[5]==i_value ? 1'b1 : 1'b0;
        6: r_equal_flag <= r_register[6]==i_value ? 1'b1 : 1'b0;
        7: r_equal_flag <= r_register[7]==i_value ? 1'b1 : 1'b0;
        default: ; 
        endcase  
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2; 
    end
endtask 
