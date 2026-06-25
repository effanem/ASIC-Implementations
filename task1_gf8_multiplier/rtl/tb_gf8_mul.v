module tb;

    reg clk = 0;
    reg rst = 1;
    reg [7:0] a, b;
    wire [7:0] y;

    // DUT
    gf8_mul dut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .y(y)
    );

    // FSDB dump (works on your VCS setup)
    initial begin
        $fsdbDumpfile("gf8_rtl_v2.fsdb");
        $fsdbDumpvars(0, tb);
    end

    // 100 MHz clock (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Reset
        a = 8'b00000000;
        b = 8'b00000000;
        #20 rst = 0;

        // Test 1: AES known vector
        // 0x57 * 0x83 = 0xC1
        a = 8'b01010111;
        b = 8'b10000011;
        #10;

        // Test 2
        // 0x02 * 0x03 = 0x06
        a = 8'b00000010;
        b = 8'b00000011;
        #10;

        // Test 3
        // 0xFF * 0x13 = 0xE5
        a = 8'b11111111;
        b = 8'b00010011;
        #10;

        #40 $finish;
    end

always @(posedge clk) begin
    $display("t=%0t  a=%h  b=%h  y=%h", $time, a, b, y);
end


endmodule

