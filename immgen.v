`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2026 12:07:19
// Design Name: 
// Module Name: immgen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module immgen(

input [24:0] instr_31_7,
input [6:0]  opcode, 
output reg [31:0]immediate
    );
    
wire [11:0]i_type = instr_31_7[24:13]; //includes Load and JALR instructions.
wire [11:0]s_type = {instr_31_7[24:18], instr_31_7[4:0]};
wire [12:0]b_type = {instr_31_7[24], instr_31_7[0], instr_31_7[23:18], instr_31_7[4:1], 1'b0};
wire [31:0]lui_pc = {instr_31_7[24:5], 12'b0}; // includes LUI and AUIPC instructions.
wire [20:0]j_type = {instr_31_7[24], instr_31_7[12:5], instr_31_7[13], instr_31_7[23:14], 1'b0};

always@(*) begin
immediate = 32'b0;
case(opcode)
    7'b0010011, 7'b0000011, 7'b1100111: immediate = {{20{instr_31_7[24]}},i_type};
    7'b0100011: immediate = {{ 20{instr_31_7[24]} }, s_type};
    7'b1100011: immediate = {{ 19{instr_31_7[24]} }, b_type};
    7'b1101111: immediate = {{ 11{instr_31_7[24]} }, j_type}; 
    7'b0110111, 7'b0010111: immediate = lui_pc;    
endcase
end
    
endmodule
