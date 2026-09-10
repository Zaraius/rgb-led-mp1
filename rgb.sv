// RGB

module top(
    input logic clk, 
    output logic RGB_R, RGB_G, RGB_B
);
    // Creating interval of 0.5s since clock is 12MHz
    parameter BLINK_INTERVAL = 6000000;
    // Creating a variable big enough to hold count up to blink interval, naming that variable count and setting it to 0
    logic [$clog2(BLINK_INTERVAL) - 1:0] count = 0;

    logic bitstring [3] = '{0, 1, 1};
    logic [2:0] pointer_idx = 0;
    logic addbit = 1;
    // Starting with all of the Green and Blue off(1 is off in this case because its active low), and Red as on 
    initial begin
        RGB_R = 1'b0;
        RGB_G = 1'b1;
        RGB_B = 1'b1;
    end

// pointer_idx = 0
// bitstring = [1, 0, 0]
// addbit = True
// for i in range(8): # in reality needs to loop forever
//     print(bitstring)
//     if addbit:
//         pointer_idx = (pointer_idx +1) % 3
//         bitstring[pointer_idx] = 1
//     else:
//         bitstring[(pointer_idx+2)%3] = 0
//     addbit = not addbit


    always_ff @(posedge clk) begin
        if (count == BLINK_INTERVAL - 1) begin
            count <= 0;
            RGB_R <= bitstring[0];
            RGB_G <= bitstring[1];
            RGB_B <= bitstring[2];
            if(addbit) begin
                pointer_idx = (pointer_idx + 1) % 3; // needs to be blocking so next state updates
                bitstring[pointer_idx] <= 0;
            end
            else begin
                bitstring[(pointer_idx+2)%3] <= 1;
            end
            addbit <= ~addbit;
        end
        else begin
            count <= count + 1;
        end

    end

// Red 1 0 0
// red Green 1 1 0
// green 0 1 0
// green blue 0 1 1
// blue 0 0 1
// red blue 1 0 1

// Start with 1 0 0, every other cycle add 1 to your right. every other cycle remove 1 from left most 1

endmodule