`timescale 1ns/1ps
module rdma_remap (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [31:0] local_addr,
    output reg  [31:0] remote_addr
);
    parameter OFFSET = 32'h8000_0000;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            remote_addr <= 32'h0;
        end
        else begin
            remote_addr <= local_addr + OFFSET;
        end
    end
endmodule
