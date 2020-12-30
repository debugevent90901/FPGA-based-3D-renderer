module get_euler_angle_matrix # (
    parameter WII = 4,
    parameter WIF = 8,
    parameter WOI = 2,
    parameter WOF = 12
)
(
    input   [WII+WIF-1:0]           alpha, beta, gamma,
    output  [15:0][WOI+WOF-1:0]     euler_angle_matrix
);

logic [WOI+WOF-1:0] zero, one;
logic [WOI+WOF-1:0] sin_alpha, cos_alpha, sin_beta, cos_beta, sin_gamma, cos_gamma;
logic [WOI+WOF-1:0] cos_alpha_cos_gamma, sin_alpha_cos_gamma, sin_beta_sin_gamma,
                    cos_alpha_sin_gamma, sin_alpha_sin_gamma, sin_beta_cos_gamma,
                    sin_beta_sin_alpha, sin_beta_cos_alpha,
                    cos_beta_sin_alpha, cos_beta_sin_alpha_sin_gamma,
                    cos_beta_cos_alpha, cos_beta_cos_alpha_sin_gamma,
                    cos_beta_sin_alpha_cos_gamma, cos_beta_cos_alpha_cos_gamma;
logic [WOI+WOF-1:0] index0, index1, index4, index5;
logic [WOI+WOF-1:0] neg_cos_alpha_sin_gamma, neg_sin_beta_cos_alpha;

logic   overflow9, overflow10, overflow11, overflow12, overflow13, overflow14, overflow15, overflow16, 
        overflow17, overflow18, overflow19, overflow20, overflow21, overflow22, overflow23, overflow24,
        overflow25, overflow26, overflow27, overflow28, overflow29, overflow30;


cal_sin # (.WII(WII), .WIF(WIF), .WOI(WOI), .WOF(WOF), .ROUND(1)) sin0 (
    .in(alpha),
    .out(sin_alpha)
);
cal_cos # (.WII(WII), .WIF(WIF), .WOI(WOI), .WOF(WOF), .ROUND(1)) cos0 (
    .in(alpha),
    .out(cos_alpha)
);

cal_sin # (.WII(WII), .WIF(WIF), .WOI(WOI), .WOF(WOF), .ROUND(1)) sin1 (
    .in(beta),
    .out(sin_beta)
);
cal_cos # (.WII(WII), .WIF(WIF), .WOI(WOI), .WOF(WOF), .ROUND(1)) cos1 (
    .in(beta),
    .out(cos_beta)
);

cal_sin # (.WII(WII), .WIF(WIF), .WOI(WOI), .WOF(WOF), .ROUND(1)) sin2 (
    .in(gamma),
    .out(sin_gamma)
);
cal_cos # (.WII(WII), .WIF(WIF), .WOI(WOI), .WOF(WOF), .ROUND(1)) cos2 (
    .in(gamma),
    .out(cos_gamma)
);



fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul0 (
    .ina(cos_alpha), 
    .inb(cos_gamma), 
    .out(cos_alpha_cos_gamma), 
    .overflow(overflow9)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul1 (
    .ina(sin_alpha), 
    .inb(cos_gamma), 
    .out(sin_alpha_cos_gamma), 
    .overflow(overflow10)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul2 (
    .ina(sin_beta), 
    .inb(sin_gamma), 
    .out(sin_beta_sin_gamma), 
    .overflow(overflow11)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul3 (
    .ina(cos_alpha), 
    .inb(sin_gamma), 
    .out(cos_alpha_sin_gamma), 
    .overflow(overflow12)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul4 (
    .ina(sin_alpha), 
    .inb(sin_gamma), 
    .out(sin_alpha_sin_gamma), 
    .overflow(overflow13)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul5 (
    .ina(sin_beta), 
    .inb(cos_gamma), 
    .out(sin_beta_cos_gamma), 
    .overflow(overflow14)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul6 (
    .ina(sin_beta), 
    .inb(sin_alpha), 
    .out(sin_beta_sin_alpha), 
    .overflow(overflow15)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul7 (
    .ina(sin_beta), 
    .inb(cos_alpha), 
    .out(sin_beta_cos_alpha), 
    .overflow(overflow16)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul8 (
    .ina(cos_beta), 
    .inb(sin_alpha), 
    .out(cos_beta_sin_alpha), 
    .overflow(overflow17)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul9 (
    .ina(cos_beta_sin_alpha), 
    .inb(sin_gamma), 
    .out(cos_beta_sin_alpha_sin_gamma), 
    .overflow(overflow18)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul10 (
    .ina(cos_beta), 
    .inb(cos_alpha), 
    .out(cos_beta_cos_alpha), 
    .overflow(overflow19)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul11 (
    .ina(cos_beta_cos_alpha), 
    .inb(sin_gamma), 
    .out(cos_beta_cos_alpha_sin_gamma), 
    .overflow(overflow20)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul12 (
    .ina(cos_beta_sin_alpha), 
    .inb(cos_gamma), 
    .out(cos_beta_sin_alpha_cos_gamma), 
    .overflow(overflow21)
);

fxp_mul #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF)) mul13 (
    .ina(cos_beta_cos_alpha), 
    .inb(cos_gamma), 
    .out(cos_beta_cos_alpha_cos_gamma), 
    .overflow(overflow22)
);


fxp_addsub #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF), .ROUND(1)) sub0 (
    .ina(cos_alpha_cos_gamma), 
    .inb(cos_beta_sin_alpha_sin_gamma), 
    .sub(1'b1), 
    .out(index0), 
    .overflow(overflow23)
);

fxp_addsub #(.WIIA(2), .WIFA(12), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF), .ROUND(1)) sub1 (
    .ina(14'b00000000000000), 
    .inb(cos_alpha_sin_gamma), 
    .sub(1'b1), 
    .out(neg_cos_alpha_sin_gamma), 
    .overflow(overflow24)
);

fxp_addsub #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF), .ROUND(1)) sub2 (
    .ina(neg_cos_alpha_sin_gamma), 
    .inb(cos_beta_sin_alpha_cos_gamma), 
    .sub(1'b1), 
    .out(index4), 
    .overflow(overflow25)
);

fxp_addsub #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF), .ROUND(1)) sub3 (
    .ina(cos_beta_cos_alpha_cos_gamma), 
    .inb(sin_alpha_sin_gamma), 
    .sub(1'b1), 
    .out(index5), 
    .overflow(overflow26)
);

fxp_addsub #(.WIIA(2), .WIFA(12), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF), .ROUND(1)) sub4 (
    .ina(14'b00000000000000), 
    .inb(sin_beta_cos_alpha), 
    .sub(1'b1), 
    .out(neg_sin_beta_cos_alpha), 
    .overflow(overflow27)
);

fxp_add #(.WIIA(WOI), .WIFA(WOF), .WIIB(WOI), .WIFB(WOF), .WOI(WOI), .WOF(WOF), .ROUND(1)) add0 (
    .ina(sin_alpha_cos_gamma),
    .inb(cos_beta_cos_alpha_sin_gamma),
    .out(index1),
    .overflow(overflow28)
);


fxp_zoom # (.WII(8), .WIF(8), .WOI(WOI), .WOF(WOF), .ROUND(1)) zoom0 (
    .in(16'h0000),
    .out(zero),
    .overflow(overflow29)
);

fxp_zoom # (.WII(8), .WIF(8), .WOI(WOI), .WOF(WOF), .ROUND(1)) zoom1 (
    .in(16'h0100),
    .out(one),
    .overflow(overflow30)
);

assign euler_angle_matrix[0] = index0;
assign euler_angle_matrix[1] = index1;
assign euler_angle_matrix[2] = sin_beta_sin_gamma;
assign euler_angle_matrix[3] = zero;

assign euler_angle_matrix[4] = index4;
assign euler_angle_matrix[5] = index5;
assign euler_angle_matrix[6] = sin_beta_cos_gamma;
assign euler_angle_matrix[7] = zero;

assign euler_angle_matrix[8] = sin_beta_sin_alpha;
assign euler_angle_matrix[9] = neg_sin_beta_cos_alpha;
assign euler_angle_matrix[10] = cos_beta;
assign euler_angle_matrix[11] = zero;

assign euler_angle_matrix[12] = zero;
assign euler_angle_matrix[13] = zero;
assign euler_angle_matrix[14] = zero;
assign euler_angle_matrix[15] = one;

endmodule


// index 0 5 error