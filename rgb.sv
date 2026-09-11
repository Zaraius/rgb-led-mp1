// RGB

module top(
    input logic clk, 
    output logic RGB_R, RGB_G, RGB_B
);
    // Creating interval of 1/6seconds since clock is 12MHz
    parameter BLINK_INTERVAL = 2000000;
    // Creating a variable big enough to hold count up to blink interval, naming that variable count and setting it to 0
    logic [$clog2(BLINK_INTERVAL) - 1:0] count = 0;
    // Counter for enumerating through colors
    logic [2:0] counter = 0;
    logic colors [0:5][0:2] = '{
        '{0, 1, 1}, // Red
        '{0, 0, 1}, // Yellow
        '{1, 0, 1}, // Green
        '{1, 0, 0}, // Cyan
        '{1, 1, 0}, // Blue
        '{0, 1, 0}}; // Magenta

    // Starting with all of the Red, Green and Blue off(1 is off in this case because its active low)
    initial begin
        RGB_R = 1'b1;
        RGB_G = 1'b1;
        RGB_B = 1'b1;
    end

    always_ff @(posedge clk) begin
        if (count == BLINK_INTERVAL - 1) begin
            count <= 0;
           // Setting led color based on 2d array and counter 
            RGB_R <= colors[counter][0];
            RGB_G <= colors[counter][1];
            RGB_B <= colors[counter][2];
            // adding to counter and reseting it to 0 if above 6
            counter <= (counter + 1) % 6;
        end
        else begin
            count <= count + 1;
        end

    end

endmodule