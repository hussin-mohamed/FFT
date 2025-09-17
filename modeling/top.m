function [X,X_for_matlab] = top(x_real,x_imag,t,id5,id6,id7,id8,id9,id10,N)
    coder.extrinsic('bin')
    %% input phase
    line2 = cast(x_imag, "like", t.line2);
    line1 = cast(x_real, "like", t.line1);
    for n = 1:2:length(line1)
        line2(n) = cast(x_real(n+1), "like", t.line2);
    end
    for n = 2:2:length(line1)
        line1(n) = cast(x_imag(n-1), "like", t.line1);
    end
    line1 = cast([0; line1], "like", t.line1);
    line2 = cast([0; line2], "like", t.line2);
    for n = 1:N
        fprintf(id8, '%s + 1i* %s \n', bin(real(line1(n+1))),bin(real(line2(n+1))));
    end
    %% stage 0
    line1_0 = cast([0; line1(1+1:8+1); line2(1+1:8+1)], "like", t.line1_0);
    line2_0 = cast([0; line1(9+1:16+1); line2(9+1:16+1)], "like", t.line2_0);
    line1_0 = cast([zeros(8,1); line1_0], "like", t.line1_0);
    line2_0 = cast([zeros(8,1); line2_0], "like", t.line2_0);
    for n = 1:N
        fprintf(id10, '%s + 1i* %s \n', bin(real(line1_0(n+8))),bin(real(line2_0(n+8))));
    end
    %% stage 1
    line1fly_1 = cast(line1_0 + line2_0, "like", t.line1fly_1);
    line2fly_1 = cast(line1_0 - line2_0, "like", t.line2fly_1);
    line2temp_1 = cast(line2fly_1, "like", t.line2temp_1);
    c = cast(zeros(1,8), "like", t.c);
    s = cast(zeros(1,8), "like", t.s);
    for n = 0:7
        c(n+1) = cast(cos(-2*pi*n/16), "like", t.c);
        s(n+1) = cast(sin(-2*pi*n/16), "like", t.s);
    end
    c = cast(transpose(c), "like", t.c);
    s = cast(transpose(s), "like", t.s);
    id1=fopen('c1.txt','w');
    id2=fopen('s1.txt','w');
    for n = 1:8
        fprintf(id1, '%s \n', bin(c(n)));
        fprintf(id2, '%s \n', bin(s(n)));
    end
    fclose(id1);
    fclose(id2);
    indices = [3, 5, 7, 9, 11, 13, 15];
    coeffs = [3, 5, 7, 2, 4, 6, 8];
    for i = 1:length(indices)
        idx = indices(i);
        coeff = coeffs(i);
        line2fly_1(idx+9) = cast((line2temp_1(idx+9) * c(coeff))- line2temp_1(idx+9 + 1) * s(coeff), "like", t.line2fly_1);
        line2fly_1(idx+9 + 1) = cast(line2temp_1(idx+9 + 1) * c(coeff) + line2temp_1(idx+9) * s(coeff), "like", t.line2fly_1);
    end
    
    line1_1 = cast([0; line1fly_1], "like", t.line1_1);
    line2_1 = cast([0; line2fly_1], "like", t.line2_1);
    line1temp_1 = cast(line1_1, "like", t.line1temp_1);
    line2temp_1 = cast(line2_1, "like", t.line2temp_1);
    line1_1 = cast([zeros(10,1); line1temp_1(1+10:4+10); line2temp_1(1+10:4+10); line1temp_1(9+10:12+10); line2temp_1(9+10:12+10)], "like", t.line1_1);
    line2_1 = cast([zeros(10,1); line1temp_1(5+10:8+10); line2temp_1(5+10:8+10); line1temp_1(13+10:16+10); line2temp_1(13+10:16+10)], "like", t.line2_1);
    line1_1 = cast([zeros(4,1); line1_1], "like", t.line1_1);
    line2_1 = cast([zeros(4,1); line2_1], "like", t.line2_1);
    for n = 1:N
        fprintf(id5, '%s + 1i* %s \n', bin(real(line1_1(n+14))),bin(real(line2_1(n+14))));
    end
    %% stage 2
    line1fly_2 = cast(line1_1 + line2_1, "like", t.line1fly_2);
    line2fly_2 = cast(line1_1 - line2_1, "like", t.line2fly_2);
    line2temp_2 = cast(line2fly_2, "like", t.line2temp_2);
    c = cast(zeros(1,4), "like", t.c);
    s = cast(zeros(1,4), "like", t.s);
    for n = 0:3
        c(n+1) = cast(cos(-2*pi*n/8), "like", t.c);
        s(n+1) = cast(sin(-2*pi*n/8), "like", t.s);
    end
    c = cast(transpose(c), "like", t.c);
    s = cast(transpose(s), "like", t.s);
    c = cast([c; c], "like", t.c);
    s = cast([s; s], "like", t.s);
    id1=fopen('c2.txt','w');
    id2=fopen('s2.txt','w');
    for n = 1:8
        fprintf(id1, '%s \n', bin(c(n)));
        fprintf(id2, '%s \n', bin(s(n)));
    end
    fclose(id1);
    fclose(id2);
    coeffs = [3,5,7,2,4,6,8];
    indices = [3, 5, 7, 9, 11, 13, 15];
    for i = 1:length(indices)
        idx = indices(i);
        coeff = coeffs(i);
        line2fly_2(idx+14) = cast(line2temp_2(idx+14) * c(coeff) - line2temp_2(idx+14 + 1) * s(coeff), "like", t.line2fly_2);
        line2fly_2(idx+14 + 1) = cast(line2temp_2(idx+14 + 1) * c(coeff) + line2temp_2(idx+14) * s(coeff), "like", t.line2fly_2);
    end
    
    line1_2 = cast([zeros(14,1); line1fly_2(1+14:2+14); line2fly_2(1+14:2+14); line1fly_2(5+14:6+14); line2fly_2(5+14:6+14); line1fly_2(9+14:10+14); line2fly_2(9+14:10+14); line1fly_2(13+14:14+14); line2fly_2(13+14:14+14)], "like", t.line1_2);
    line2_2 = cast([zeros(14,1); line1fly_2(3+14:4+14); line2fly_2(3+14:4+14); line1fly_2(7+14:8+14); line2fly_2(7+14:8+14); line1fly_2(11+14:12+14); line2fly_2(11+14:12+14); line1fly_2(15+14:16+14); line2fly_2(15+14:16+14)], "like", t.line2_2);
    line1_2 = cast([0; line1_2], "like", t.line1_2);
    line2_2 = cast([0; line2_2], "like", t.line2_2);
    line1_2 = cast([zeros(2,1); line1_2], "like", t.line1_2);
    line2_2 = cast([zeros(2,1); line2_2], "like", t.line2_2);
    for n = 1:N
        fprintf(id6, '%s + 1i* %s \n', bin(real(line1_2(n+17))),bin(real(line2_2(n+17))));
    end
    %% stage 3
    line1fly_3 = cast(line1_2 + line2_2, "like", t.line1fly_3);
    line2fly_3 = cast(line1_2 - line2_2, "like", t.line2fly_3);
    line2temp_3 = cast(line2fly_3, "like", t.line2temp_3);
    c = cast(zeros(1,2), "like", t.c);
    s = cast(zeros(1,2), "like", t.s);
    for n = 0:1
        c(n+1) = cast(cos(-2*pi*n/4), "like", t.c);
        s(n+1) = cast(sin(-2*pi*n/4), "like", t.s);
    end
    c = cast(transpose(c), "like", t.c);
    s = cast(transpose(s), "like", t.s);
    c = cast([c; c; c; c], "like", t.c);
    s = cast([s; s; s; s], "like", t.s);
    id1=fopen('c3.txt','w');
    id2=fopen('s3.txt','w');
    for n = 1:8
        fprintf(id1, '%s \n', bin(c(n)));
        fprintf(id2, '%s \n', bin(s(n)));
    end
    fclose(id1);
    fclose(id2);
    coeffs = [3,5,7,2,4,6,8];
    indices = [3, 5, 7, 9, 11, 13, 15];
    for i = 1:length(indices)
        idx = indices(i);
        coeff = coeffs(i);
        line2fly_3(idx+17) = cast(line2temp_3(idx+17) * c(coeff) - line2temp_3(idx+17 + 1) * s(coeff), "like", t.line2fly_3);
        line2fly_3(idx+17 + 1) = cast(line2temp_3(idx+17 + 1) * c(coeff) + line2temp_3(idx+17) * s(coeff), "like", t.line2fly_3);
    end
    
    line1_3 = cast([0; line1fly_3], "like", t.line1_3);
    line2_3 = cast([0; line2fly_3], "like", t.line2_3);
    line1temp_3 = cast(line1_3, "like", t.line1temp_3);
    line2temp_3 = cast(line2_3, "like", t.line2temp_3);
    line1_3 = cast([zeros(18,1); line1temp_3(1+18:8+18); line2temp_3(1+18:8+18)], "like", t.line1_3);
    line2_3 = cast([zeros(18,1); line1temp_3(9+18:16+18); line2temp_3(9+18:16+18)], "like", t.line2_3);
    line1_3 = cast([zeros(8,1); line1_3], "like", t.line1_3);
    line2_3 = cast([zeros(8,1); line2_3], "like", t.line2_3);
    for n = 1:N
        fprintf(id7, '%s + 1i* %s \n', bin(real(line1_3(n+26))),bin(real(line2_3(n+26))));
    end
    %% stage 4
    line1_4 = cast(line1_3 + line2_3, "like", t.line1_4);
    line2_4 = cast(line1_3 - line2_3, "like", t.line2_4);
    for n = 1:N
        fprintf(id9,'%s + 1i *%s \n',bin(line1_4(n+26)),bin(line2_4(n+26)));
    end
    %% output phase
    line2_temp = cast(line2_4, "like", t.line2_temp);
    line1_temp = cast(line1_4, "like", t.line1_temp);
    for n = 1:2:length(line1_temp)
        line2_temp(n) = cast(line1_4(n+1), "like", t.line2_temp);
    end
    for n = 2:2:length(line1_temp)
        line1_temp(n) = cast(line2_4(n-1), "like", t.line1_temp);
    end
    % for n = 1:N
    %     fprintf(id9, '%s + 1i* %s \n', bin(real(line1_temp(n+27))),bin(real(line2_temp(n+27))));
    % end
    X = cast([0; line1_temp], "like", t.X) + 1i * cast([0; line2_temp], "like", t.X);
    temp = cast([X(1+27:16+27)], "like", t.temp);
    X_for_matlab = cast([X(1+27); temp(9); temp(5); temp(13); temp(3); temp(11); temp(7); temp(15); temp(2); temp(10); temp(6); temp(14); temp(4); temp(12); temp(8); X(16+27)], "like", t.X); 
    X_for_matlab = cast([X_for_matlab(1); X_for_matlab(3); X_for_matlab(5); X_for_matlab(7); X_for_matlab(2); X_for_matlab(4); X_for_matlab(6); X_for_matlab(8); X_for_matlab(9); X_for_matlab(11); X_for_matlab(13); X_for_matlab(15); X_for_matlab(10); X_for_matlab(12); X_for_matlab(14); X_for_matlab(16)], "like", t.X);
    X=temp;
end
