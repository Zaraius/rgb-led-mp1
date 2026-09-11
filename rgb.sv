// RGB

module top(
    input logic clk, 
    output logic RGB_R, RGB_G, RGB_B
);
    // Creating interval of 0.5s since clock is 12MHz
    parameter BLINK_INTERVAL = 2000000;
    // Creating a variable big enough to hold count up to blink interval, naming that variable count and setting it to 0
    logic [$clog2(BLINK_INTERVAL) - 1:0] count = 0;
    logic [0:3] counter = 0;

    logic colors [0:5][0:2] = '{
        '{0, 1, 1},
        '{0, 0, 1},
        '{1, 0, 1},
        '{1, 0, 0},
        '{1, 1, 0},
        '{0, 1, 0}};
    // Starting with all of the Green and Blue off(1 is off in this case because its active low), and Red as on 
    initial begin
        RGB_R = 1'b1;
        RGB_G = 1'b1;
        RGB_B = 1'b1;
    end

    always_ff @(posedge clk) begin
        if (count == BLINK_INTERVAL - 1) begin
            count <= 0;
            RGB_R <= colors[counter][0];
            RGB_G <= colors[counter][1];
            RGB_B <= colors[counter][2];
            counter <= (counter + 1) % 6;
        end
        else begin
            count <= count + 1;
        end

    end

endmodule