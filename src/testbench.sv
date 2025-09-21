module tb;
    reg clk = 0;
    reg rst_n = 0;
    reg [31:0] local_addr;
    wire [31:0] remote_addr;
    
    always #10 clk = ~clk; 
    
    rdma_remap dut (
        .clk(clk),
        .rst_n(rst_n),
        .local_addr(local_addr),
        .remote_addr(remote_addr)
    );
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
        
        #15 rst_n = 1; 
        
        local_addr = 32'h1000;
        #20; 
        if (remote_addr !== 32'h80001000)
            $error("Test1 Failed");
        
        local_addr = 32'hFFFF0000;
        #20;
        if (remote_addr !== 32'h7FFF0000)  
            $error("Test2 Failed");
            
        $display("All tests passed!");
        $finish;
    end
endmodule
