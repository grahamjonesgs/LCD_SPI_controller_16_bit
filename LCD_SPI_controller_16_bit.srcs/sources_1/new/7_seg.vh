 // Set 7 Seg LED vaue
 // On completion
 // Increament PC 3
 // Increamaent r_SM_msg
   
task t_7_seg_value;
input [15:0] i_byte; 
    begin
        r_seven_seg_value<={4'h0,i_byte[15:12],4'h0,i_byte[11:8],4'h0,i_byte[7:4],4'h0,i_byte[3:0]};
        r_SM_msg<=OPCODE_REQUEST;  
        r_PC<=r_PC+3;    
    end
endtask 