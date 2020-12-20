module list_writer #(
                    parameter WI = 8,
                    parameter WF = 8
)
(
                    input Clk, Reset,
                    input load_obj,
                    output logic list_w,
                    output logic [2:0][2:0][WI+WF-1:0] orig_triangle_in
);

    enum logic [3:0] {Wait, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, Done} curr_state, next_state;

    logic [2:0][2:0][WI+WF-1:0] orig_triangle, new_orig_triangle;
    logic [2:0][WI+WF-1:0]      P1, P2, P3, P4, P5, P6, P7, P8;

    assign P1 = 48'h000000000000;
    assign P2 = 48'h000000000100;
    assign P3 = 48'h000001000000;
    assign P4 = 48'h000001000100;
    assign P5 = 48'h010000000000;
    assign P6 = 48'h010000000100;
    assign P7 = 48'h010001000000;
    assign P8 = 48'h010001000100;

    always_ff @(posedge Clk)
    begin
        if (Reset)
        begin
            curr_state <= Wait;
            orig_triangle <= 0;
        end
        else
        begin
            curr_state <= next_state;
            orig_triangle <= new_orig_triangle;
        end
    end

    always_comb
    begin
        next_state = curr_state;
        list_w = 1'b0;
        new_orig_triangle = orig_triangle;
		  orig_triangle_in = orig_triangle;
        
        unique case (curr_state)
        Wait:
        begin
            if(load_obj)
                next_state = W1;
        end
        W1:
        begin
            next_state = W2;
        end
        W2:
        begin
            next_state = W3;
        end
        W3:
        begin
            next_state = W4;
        end
        W4:
        begin
            next_state = W5;
        end
        W5:
        begin
            next_state = W6;
        end
        W6:
        begin
            next_state = W7;
        end
        W7:
        begin
            next_state = W8;
        end
        W8:
        begin
            next_state = W9;
        end
        W9:
        begin
            next_state = W10;
        end
        W10:
        begin
            next_state = W11;
        end
        W11:
        begin
            next_state = W12;
        end
        W12:
        begin
            next_state = Done;
        end
        Done:
        begin
        end
        endcase

        case (curr_state)
        Wait:
        begin
            new_orig_triangle = {P1, P2, P3};
        end
        W1:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P2, P3, P4};
        end
        W2:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P1, P2, P5};
        end
        W3:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P2, P5, P6};
        end
        W4:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P1, P3, P5};
        end
        W5:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P3, P5, P7};
        end
        W6:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P2, P4, P8};
        end
        W7:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P2, P8, P6};
        end
        W8:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P3, P4, P7};
        end
        W9:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P4, P7, P8};
        end
        W10:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P5, P6, P7};
        end
        W11:
        begin
            list_w = 1'b1;
            new_orig_triangle = {P6, P7, P8};
        end
        W12:
        begin
            list_w = 1'b1;
        end
        Done:
        begin
        end
        endcase
    end

endmodule