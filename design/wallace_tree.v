module wallace (
    input [11:0] a, b, output [11:0] product
);
    wire [11:0][11:0] p;
    genvar i, j;
    generate
        for (i = 0; i < 12; i = i + 1) begin : gen_row
            for (j = 0; j < 12 - i; j = j + 1) begin : gen_col
                assign p[i][j] = a[i] & b[j];
            end
        end
    endgenerate
    //coloumn 1
    assign product[0] = p[0][0];
    //coloumn 2
    wire c0;
    halfadder ha1 (
        .a(p[0][1]),
        .b(p[1][0]),
        .sum(product[1]),
        .cout(c0)
    );
    //coloumn 3
    wire c1,s0;
    halfadder ha2 (
        .a(p[0][2]),
        .b(p[1][1]),
        .sum(s0),
        .cout(c1)
    );
    wire c2;
    fulladder fa1 (
        .a(s0),
        .b(p[2][0]),
        .cin(c0),
        .sum(product[2]),
        .cout(c2)
    );
    //coloumn 4
    wire c3,s1;
    fulladder fa2 (
        .a(p[0][3]),
        .b(p[1][2]),
        .cin(p[2][1]),
        .sum(s1),
        .cout(c3)
    );
    wire c4,s2;
    halfadder ha3 (
        .a(s1),
        .b(p[3][0]),
        .sum(s2),
        .cout(c4)
    );
    wire c5;
    fulladder fa3 (
        .a(s2),
        .b(c1),
        .cin(c2),
        .sum(product[3]),
        .cout(c5)
    );
    //coloumn 5
    wire c6,s3;
    fulladder fa4 (
        .a(p[0][4]),
        .b(p[1][3]),
        .cin(p[2][2]),
        .sum(s3),
        .cout(c6)
    );
    wire c7,s4;
    halfadder ha4 (
        .a(p[3][1]),
        .b(p[4][0]),
        .sum(s4),
        .cout(c7)
    );
    wire c8,s5;
    fulladder fa5 (
        .a(s3),
        .b(s4),
        .cin(c3),
        .sum(s5),
        .cout(c8)
    );
    wire c9;
    fulladder fa6 (
        .a(s5),
        .b(c4),
        .cin(c5),
        .sum(product[4]),
        .cout(c9)
    );
    //coloumn 6
    wire c10,s6;
    fulladder fa7 (
        .a(p[0][5]),
        .b(p[1][4]),
        .cin(p[2][3]),
        .sum(s6),
        .cout(c10)
    );
    wire c11,s7;
    fulladder fa8 (
        .a(p[3][2]),
        .b(p[4][1]),
        .cin(p[5][0]),
        .sum(s7),
        .cout(c11)
    );
    wire c12,s8;
    fulladder fa9 (
        .a(s6),
        .b(s7),
        .cin(c6),
        .sum(s8),
        .cout(c12)
    );
    wire c13,s9;
    halfadder ha5 (
        .a(s8),
        .b(c7),
        .sum(s9),
        .cout(c13)
    );
    wire c14;
    fulladder fa10 (
        .a(s9),
        .b(c8),
        .cin(c9),
        .sum(product[5]),
        .cout(c14)
    );
    //coloumn 7
    wire c15,s10;
    fulladder fa11 (
        .a(p[0][6]),
        .b(p[1][5]),
        .cin(p[2][4]),
        .sum(s10),
        .cout(c15)
    );
    wire c16,s11;
    fulladder fa12 (
        .a(p[3][3]),
        .b(p[4][2]),
        .cin(p[5][1]),
        .sum(s11),
        .cout(c16)
    );
    wire c17,s12;
    fulladder fa13 (
        .a(s10),
        .b(s11),
        .cin(p[6][0]),
        .sum(s12),
        .cout(c17)
    );
    wire c18,s13;
    fulladder fa14 (
        .a(s12),
        .b(c10),
        .cin(c11),
        .sum(s13),
        .cout(c18)
    );
    wire c19,s14;
    halfadder ha6 (
        .a(s13),
        .b(c12),
        .sum(s14),
        .cout(c19)
    );
    wire c20;
    fulladder fa15 (
        .a(s14),
        .b(c13),
        .cin(c14),
        .sum(product[6]),
        .cout(c20)
    );
    //coloumn 8
    wire c21,s15;
    halfadder ha7 (
        .a(p[7][0]),
        .b(p[6][1]),
        .sum(s15),
        .cout(c21)
    );
    wire c22,s16;
    fulladder fa16 (
        .a(p[3][4]),
        .b(p[4][3]),
        .cin(p[5][2]),
        .sum(s16),
        .cout(c22)
    );
    wire c23,s17;
    fulladder fa17 (
        .a(p[0][7]),
        .b(p[1][6]),
        .cin(p[2][5]),
        .sum(s17),
        .cout(c23)
    );
    wire c24,s18;
    fulladder fa18 (
        .a(s15),
        .b(s16),
        .cin(s17),
        .sum(s18),
        .cout(c24)
    );
    wire c25,s19;
    fulladder fa19 (
        .a(s18),
        .b(c15),
        .cin(c16),
        .sum(s19),
        .cout(c25)
    );
    wire c26,s20;
    fulladder fa20 (
        .a(s19),
        .b(c17),
        .cin(c18),
        .sum(s20),
        .cout(c26)
    );
    wire c27;
    fulladder fa21 (
        .a(s20),
        .b(c19),
        .cin(c20),
        .sum(product[7]),
        .cout(c27)
    );
    //coloumn 9
    wire c28,s21;
    fulladder fa22 (
        .a(p[0][8]),
        .b(p[1][7]),
        .cin(p[2][6]),
        .sum(s21),
        .cout(c28)
    );
    wire c29,s22;
    fulladder fa23 (
        .a(p[3][5]),
        .b(p[4][4]),
        .cin(p[5][3]),
        .sum(s22),
        .cout(c29)
    );
    wire c30,s23;
    fulladder fa24 (
        .a(p[6][2]),
        .b(p[7][1]),
        .cin(p[8][0]),
        .sum(s23),
        .cout(c30)
    );
    wire c31,s24;
    fulladder fa25 (
        .a(s21),
        .b(s22),
        .cin(s23),
        .sum(s24),
        .cout(c31)
    );
    wire c32,s25;
    fulladder fa26 (
        .a(s24),
        .b(c22),
        .cin(c21),
        .sum(s25),
        .cout(c32)
    );
    wire c33,s26;
    fulladder fa27 (
        .a(s25),
        .b(c23),
        .cin(c24),
        .sum(s26),
        .cout(c33)
    );
    wire c34,s27;
    halfadder ha8 (
        .a(s26),
        .b(c25),
        .sum(s27),
        .cout(c34)
    );
    wire c35;
    fulladder fa28 (
        .a(s27),
        .b(c26),
        .cin(c27),
        .sum(product[8]),
        .cout(c35)
    );
    //coloumn 10
    wire c36,s28;
    fulladder fa29 (
        .a(p[0][9]),
        .b(p[1][8]),
        .cin(p[2][7]),
        .sum(s28),
        .cout(c36)
    );
    wire c37,s29;
    fulladder fa30 (
        .a(p[3][6]),
        .b(p[4][5]),
        .cin(p[5][4]),
        .sum(s29),
        .cout(c37)
    );
    wire c38,s30;
    fulladder fa31 (
        .a(p[6][3]),
        .b(p[7][2]),
        .cin(p[8][1]),
        .sum(s30),
        .cout(c38)
    );
    wire c39,s31;
    fulladder fa32 (
        .a(s30),
        .b(p[9][0]),
        .cin(s28),
        .sum(s31),
        .cout(c39)
    );
    wire c40,s32;
    fulladder fa33 (
        .a(s31),
        .b(s28),
        .cin(s29),
        .sum(s32),
        .cout(c40)
    );
    wire c41,s33;
    fulladder fa34 (
        .a(s32),
        .b(c29),
        .cin(c30),
        .sum(s33),
        .cout(c41)
    );
    wire c42,s34;
    fulladder fa35 (
        .a(s33),
        .b(c31),
        .cin(c32),
        .sum(s34),
        .cout(c42)
    );
    wire c43s,35;
    halfadder ha9 (
        .a(s34),
        .b(c33),
        .sum(s35),
        .cout(c43)
    );
    wire c44;
    fulladder fa36 (
        .a(s35),
        .b(c34),
        .cin(c35),
        .sum(product[9]),
        .cout(c44)
    );
    //coloumn 11
endmodule