`timescale 1ns/1ps

module rdma_remap (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        start,
    input  wire [31:0] local_addr,
    output reg  [31:0] remote_addr,
    output reg         ready
);

    parameter OFFSET = 32'h8000_0000;

    localparam IDLE  = 2'b00;
    localparam CALC  = 2'b01;
    localparam DONE  = 2'b10;
    
    reg [1:0] current_state;
    reg [1:0] next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end
  
    always @(*) begin
        case (current_state)
            IDLE: begin
                ready = 1'b0;
                remote_addr = 32'h0;
                if (start) begin
                    next_state = CALC;
                end else begin
                    next_state = IDLE;
                end
            end
            
            CALC: begin
                ready = 1'b0;
                remote_addr = local_addr + OFFSET;
                next_state = DONE;
            end
            
            DONE: begin
                ready = 1'b1;
                remote_addr = local_addr + OFFSET;  
                if (!start) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
            
            default: begin
                ready = 1'b0;
                remote_addr = 32'h0;
                next_state = IDLE;
            end
        endcase
    end
endmodule
