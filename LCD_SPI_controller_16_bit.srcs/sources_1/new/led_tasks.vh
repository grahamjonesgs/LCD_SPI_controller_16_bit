 // Set LED signal status
 // On completion
 // Increament PC 2
 // Increamaent r_SM_msg
   
task t_led_state;
input i_state; 
    begin
        o_led<=i_state;
        r_SM_msg<=OPCODE_REQUEST;  
        r_PC<=r_PC+2;    
    end
endtask 