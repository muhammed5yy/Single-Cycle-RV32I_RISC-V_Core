`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2025 11:42:15
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input [2:0]funct3,
    input [6:0]funct7,
    input [1:0]ALU_Op,
    output reg [3:0]op
);

always@(*) 
begin
op = 4'b1111;
if (ALU_Op == 2'b00) // Common
    begin
    op = 4'b0000;
end

else if (ALU_Op == 2'b01) // Branch
    begin
    op = 4'b0001;
end

else if (ALU_Op == 2'b11) // R-Type
    begin       
    case(funct3)
    3'b001: op = 4'b0111;
    3'b010: op = 4'b0101;
    3'b011: op = 4'b0110;
    3'b100: op = 4'b0100;  
    3'b110: op = 4'b1000;
    3'b111: op = 4'b0010;
    3'b000: op = (funct7[5]) ? 4'b0001 : 4'b0000;
    3'b101: op = (funct7[5]) ? 4'b1001 : 4'b1000;
    default: op = 4'b1111;
    endcase
end
    
else if (ALU_Op == 2'b10) begin // I-Type
    case(funct3)
    3'b000: op = 4'b0000;
    3'b010: op = 4'b0101;
    3'b011: op = 4'b0110;
    3'b100: op = 4'b0100;
    3'b110: op = 4'b0011;
    3'b111: op = 4'b0010;
    3'b001: op = 4'b0111;
    3'b101: begin
    if (funct7[5])
    op = 4'b1001;    
    else 
    op = 4'b1000;
    end
    default: op = 4'b1111;
    endcase
end   
    
    
end
endmodule
