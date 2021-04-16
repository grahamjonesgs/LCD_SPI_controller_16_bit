// SPI Write to LCD as command
 // On completion
 // Increment PC by 1
 // Increamaent r_SM
 task t_test_msg;
    begin
    r_msg[7:0]<=8'h40;
    r_msg[15:8]<=8'h41;
    r_msg[23:16]<=8'h42;
    r_msg[31:24]<=8'h43;
    r_msg[39:32]<=8'h44; 
    r_msg_length<=8'h5;
    r_msg_send_DV<=1'b1;
    
    
    r_SM<=OPCODE_REQUEST;  
    r_PC<=r_PC+1;    
    
    
    end
endtask

task t_tx_message;
    input [7:0] i_message_number;
    begin
        case (i_message_number)
        1: // Load Complete OK
        begin 
            r_msg[7:0]<=8'd76;
            r_msg[15:8]<=8'd111;
            r_msg[23:16]<=8'd97;
            r_msg[31:24]<=8'd100;
            r_msg[39:32]<=8'd32;
            r_msg[47:40]<=8'd67;
            r_msg[55:48]<=8'd111;
            r_msg[63:56]<=8'd109;
            r_msg[71:64]<=8'd112;
            r_msg[79:72]<=8'd108;
            r_msg[87:80]<=8'd101;
            r_msg[95:88]<=8'd116;
            r_msg[103:96]<=8'd101;
            r_msg[111:104]<=8'd32;
            r_msg[119:112]<=8'd79;
            r_msg[127:120]<=8'd75;
            r_msg[135:128]<=8'd13;
            r_msg[143:136]<=8'd10;
            r_msg_length<=8'd18;
            
            r_msg_send_DV<=1'b1;
        end
        2: // Load Error, bad CRC
        begin 
            r_msg[7:0]<=8'h4C;
            r_msg[15:8]<=8'h6F;
            r_msg[23:16]<=8'h61;
            r_msg[31:24]<=8'h64;
            r_msg[39:32]<=8'h20;
            r_msg[47:40]<=8'h45;
            r_msg[55:48]<=8'h72;
            r_msg[63:56]<=8'h72;
            r_msg[71:64]<=8'h6F;
            r_msg[79:72]<=8'h72;
            r_msg[87:80]<=8'h2C;
            r_msg[95:88]<=8'h20;
            r_msg[103:96]<=8'h62;
            r_msg[111:104]<=8'h61;
            r_msg[119:112]<=8'h64;
            r_msg[127:120]<=8'h20;
            r_msg[135:128]<=8'h43;
            r_msg[143:136]<=8'h52;
            r_msg[151:144]<=8'h43;
            r_msg[159:152]<=8'hA;
            r_msg[167:160]<=8'hD;
            r_msg_length<=8'h43;
            
            r_msg_send_DV<=1'b1;
        end
        3:
        begin
        
        end
        default:
            begin
                r_msg[7:0]<=8'h00;
                r_msg_length<=8'h0;
            end
        endcase;
    end 
endtask        