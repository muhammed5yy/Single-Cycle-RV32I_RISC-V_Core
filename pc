`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2025 18:04:16
// Design Name: 
// Module Name: pc
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


module pc
(
input clk,
input reset,
input [31:0] new_inst,

output reg [31:0] current_inst
);


always@(posedge clk or posedge reset) begin
	if (reset) begin
		current_inst <= 32'b0;
	end else begin
		current_inst <= new_inst;
	end
end
endmodule		
