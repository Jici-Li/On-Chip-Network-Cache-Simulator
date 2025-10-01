module tb;
    reg clk = 0;
    reg rst_n = 0;
    reg start = 0;
    reg [31:0] local_addr;
    wire [31:0] remote_addr;
    wire ready;
    
    always #10 clk = ~clk; 
    
    rdma_remap dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .local_addr(local_addr),
        .remote_addr(remote_addr),
        .ready(ready)
    );
    
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
        
        #15 rst_n = 1; 
        
        local_addr = 32'h1000;
        start = 1;
        #20; 
        if (remote_addr !== 32'h80001000)
            $error("Test1 Failed: got %h, expected %h", remote_addr, 32'h80001000);
        else
            $display("Test1 Passed: %h -> %h", local_addr, remote_addr);
        
        local_addr = 32'hFFFF0000;
        start = 1;
        #20;
        if (remote_addr !== 32'h7FFF0000)  
            $error("Test2 Failed: got %h, expected %h", remote_addr, 32'h7FFF0000);
        else
            $display("Test2 Passed: %h -> %h", local_addr, remote_addr);

        local_addr = 32'h00000000;
        start = 1;
        #20;
        if (remote_addr !== 32'h80000000)
            $error("Test3 Failed: got %h, expected %h", remote_addr, 32'h80000000);
        else
            $display("Test3 Passed: %h -> %h", local_addr, remote_addr);

        local_addr = 32'h7FFFFFFF;
        start = 1;
        #20;
        if (remote_addr !== 32'hFFFFFFFF)
            $error("Test4 Failed: got %h, expected %h", remote_addr, 32'hFFFFFFFF);
        else
            $display("Test4 Passed: %h -> %h", local_addr, remote_addr);
            
        $display("All tests passed!");
        $finish;
    end
endmodule
