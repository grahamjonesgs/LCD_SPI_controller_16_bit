// Single-Port Block RAM No-Change Mode
// File: rams_sp_nc.v

module stack (
           input clk,
           input i_reset,
           input i_read_flag,
           input i_write_flag,
           input [15:0] i_write_value,
           input [15:0] i_peek_pointer,
           output reg [15:0] o_stack_top_value,
           output reg [15:0] o_stack_peek_value,
           output reg o_stack_error
       );

(* ram_style = "block" *) reg [15:0] RAM [1023:0];
reg [15:0] r_stack_pointer;

/*   ila_0  myila2(.clk(clk),
   .probe0(o_stack_top_value),
   .probe1(r_stack_pointer),
   .probe2(r_PC),
   .probe3(i_write_value),
   .probe4(o_stack_top_value),
   .probe5(1'b0),
   .probe6(1'b0),
   .probe7(1'b0),
   .probe8(1'b0),
   .probe9(1'b0),
   .probe10(1'b0),
   .probe11(1'b0),
   .probe12(1'b0),
   .probe13(o_stack_error),
   .probe14(i_write_flag),
   .probe15(i_read_flag)); */


initial
begin
    r_stack_pointer=15'h0;
    o_stack_error=1'b0;
end

always @(posedge clk)
begin
    if (i_reset)
    begin
        r_stack_pointer<=15'h0;
        o_stack_error<=1'b0;
    end //if (i_reset)
    else
    begin
        if (i_read_flag)
        begin
            if (r_stack_pointer==0)
            begin
                o_stack_error<=1;
            end // if(r_stack_pointer==0)
            else
            begin
                r_stack_pointer<=r_stack_pointer-1;
            end // else if if(r_stack_pointer==0)
        end // if (i_read)
        if (i_write_flag)
        begin
            if (r_stack_pointer>1022)
            begin
                o_stack_error<=1;
            end // if (r_stack_pointer>1022)
            else
            begin
                RAM[r_stack_pointer]<=i_write_value;
                r_stack_pointer<=r_stack_pointer+1;
            end // else if (r_stack_pointer>1022)
        end //if (i_write_flag)
    end // else if (i_reset)
end // always clock

always @(posedge clk)
begin
    o_stack_top_value<=RAM[r_stack_pointer-1];
    o_stack_peek_value=RAM[r_stack_pointer-i_peek_pointer];
end

endmodule
