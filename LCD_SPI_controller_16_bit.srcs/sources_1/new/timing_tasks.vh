 // Will delay execution input value *2^19 ticks
 // On completion
 // Increament PC 2
 // Increamaent r_SM_msg
 
 task t_delay;
    input [15:0] i_timeout_fraction; 
    begin
        r_timeout_max<=i_timeout_fraction << 11;
        if(r_timeout_counter>=r_timeout_max)  
        begin 
            r_timeout_counter<=0;
            r_SM_msg<=OPCODE_REQUEST;
            r_PC<=r_PC+2;
        end  // if(r_timeout_counter>=DELAY_TIME)
        else
        begin
            r_timeout_counter<=r_timeout_counter+1;               
        end // else if(r_timeout_counter>=DELAY_TIME)
    end
endtask 

 // Will delay execution input value *2^19 ticks
 // On completion
 // Increament PC 2
 // Increamaent r_SM_msg
 
 task t_delay_reg;
    reg [15:0] r_timeout_fraction; 
    begin
    case(w_opcode[3:0]) //Block assignment
        0: r_timeout_fraction=r_register[0];
        1: r_timeout_fraction=r_register[1];
        2: r_timeout_fraction=r_register[2];
        3: r_timeout_fraction=r_register[3];
        4: r_timeout_fraction=r_register[4];
        5: r_timeout_fraction=r_register[5];
        6: r_timeout_fraction=r_register[6];
        7: r_timeout_fraction=r_register[7];     
        default:r_timeout_fraction=16'h0 ;
    endcase 
        r_timeout_max<=r_timeout_fraction << 11;
        if(r_timeout_counter>=r_timeout_max)  
        begin 
            r_timeout_counter<=0;
            r_SM_msg<=OPCODE_REQUEST;
            r_PC<=r_PC+1;
        end  // if(r_timeout_counter>=DELAY_TIME)
        else
        begin
            r_timeout_counter<=r_timeout_counter+1;               
        end // else if(r_timeout_counter>=DELAY_TIME)
    end
endtask 