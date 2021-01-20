 // Set 7 Seg LED vaue
 // On completion
 // Increament PC 2
 // Increamaent r_SM_msg
   
task t_7_seg_value;
input [15:0] i_byte; 
    begin
        r_seven_seg_value<={4'h0,i_byte[15:12],4'h0,i_byte[11:8],4'h0,i_byte[7:4],4'h0,i_byte[3:0]};
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+2;    
    end
endtask 

 // Set 7 Seg LED vaue
 // On completion
 // Increament PC
 // Increamaent r_SM_msg
   
task t_7_seg_reg;
input [15:0] i_byte; 
    begin
    case(w_opcode[3:0])
                0: r_seven_seg_value<={4'h0,r_register[0][15:12],4'h0,r_register[0][11:8],4'h0,r_register[0][7:4],4'h0,r_register[0][3:0]};
                1: r_seven_seg_value<={4'h0,r_register[1][15:12],4'h0,r_register[1][11:8],4'h0,r_register[1][7:4],4'h0,r_register[1][3:0]};
                2: r_seven_seg_value<={4'h0,r_register[2][15:12],4'h0,r_register[2][11:8],4'h0,r_register[2][7:4],4'h0,r_register[2][3:0]};
                3: r_seven_seg_value<={4'h0,r_register[3][15:12],4'h0,r_register[3][11:8],4'h0,r_register[3][7:4],4'h0,r_register[3][3:0]};
                4: r_seven_seg_value<={4'h0,r_register[4][15:12],4'h0,r_register[4][11:8],4'h0,r_register[4][7:4],4'h0,r_register[4][3:0]};
                5: r_seven_seg_value<={4'h0,r_register[5][15:12],4'h0,r_register[5][11:8],4'h0,r_register[5][7:4],4'h0,r_register[5][3:0]};
                6: r_seven_seg_value<={4'h0,r_register[6][15:12],4'h0,r_register[6][11:8],4'h0,r_register[6][7:4],4'h0,r_register[6][3:0]};
                7: r_seven_seg_value<={4'h0,r_register[7][15:12],4'h0,r_register[7][11:8],4'h0,r_register[7][7:4],4'h0,r_register[7][3:0]};              
                default: ; 
     endcase 
        r_SM<=OPCODE_REQUEST;  
        r_PC<=r_PC+1;    
    end
endtask 