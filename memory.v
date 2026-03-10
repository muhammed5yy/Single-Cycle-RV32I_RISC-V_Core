`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2026 12:31:02
// Design Name: 
// Module Name: memory
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


module memory(
    input  clk,
    input  MemWrite,
    input  MemRead,
    input  [31:0]address,
    input  [31:0]data_in,
    output [31:0]data_out
);
    
    reg [31:0] RAM [0:8191];
    
    always@(posedge clk) begin
       
        if (MemWrite) begin
            RAM[address[14:2]] <= data_in;
        end
    end     
    
    assign data_out = (MemRead) ? RAM[address[14:2]] : 32'b0;
        
endmodule
