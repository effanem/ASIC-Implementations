module gf8_mul (
    input  wire       clk,
    input  wire       rst,
    input  wire [7:0] a,
    input  wire [7:0] b,
    output reg  [7:0] y
);

    reg [15:0] prod;
    reg [7:0]  red;
    integer i;

    // Combinational GF multiply + reduction
    always @(*) begin
        prod = 16'b0000000000000000;

        // Multiply in GF(2): shift + XOR
        for (i = 0; i < 8; i = i + 1) begin
            if (b[i])
                prod = prod ^ (a << i);
        end

        // Reduce modulo AES polynomial
        // x^8 = x^4 + x^3 + x + 1  →  00011011
        red = prod[7:0];
        for (i = 15; i >= 8; i = i - 1) begin
            if (prod[i]) begin
                red = red ^ (8'b00011011 << (i - 8));
            end
        end
    end

    // Pipeline register (1-cycle latency)
    always @(posedge clk) begin
        if (rst)
            y <= 8'b00000000;
        else
            y <= red;
    end

endmodule

