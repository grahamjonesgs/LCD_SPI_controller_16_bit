module rams_sp_nc (clk, opcode_read_addr, dout_opcode, dout_var1,dout_var2, write_en, write_addr, write_value);

input clk;

input [14:0] opcode_read_addr;
output reg [15:0] dout_opcode;
output reg [15:0] dout_var1;
output reg [15:0] dout_var2;
input [11:0] write_addr;
input [15:0] write_value;
input write_en;

(* ram_style = "block" *) reg [15:0] RAM [32767:0];

initial
begin
    $readmemh("lcd_data.mem",RAM);
end

always @(posedge clk)
begin
    dout_opcode <= RAM[opcode_read_addr];
    dout_var1 <= RAM[opcode_read_addr+1];
    dout_var2 <= RAM[opcode_read_addr+2];
    if (write_en)
    begin
        RAM[write_addr] <= write_value;
    end
end
endmodule
