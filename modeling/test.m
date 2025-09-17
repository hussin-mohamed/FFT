clear;clc;close all;
%% design parameters
N=16; %length of the data
nseeds=100;
x_axis=zeros(nseeds,1);
error=zeros(nseeds,1);
e=zeros(N,nseeds);
id1 = fopen('input_imaginary.txt', 'w');
id2 = fopen('input_real.txt', 'w');
id3 = fopen('output_real.txt', 'w');
id4 = fopen('output_imaginary.txt', 'w');
id5 = fopen('stage1.txt', 'w');
id6 = fopen('stage2.txt', 'w');
id7 = fopen('stage3.txt', 'w');
id8 = fopen('input_phase.txt', 'w');
id9 = fopen('line2rotator.txt', 'w');
id10 = fopen('stage0.txt', 'w');
SQNR=zeros(nseeds,1);
str='fixed';
t=types(str);
%% driving and calculating actual value
for seed= 1:nseeds
    x_axis(seed)=seed;
    rng(seed);
    x_real=randn(N,1);
    x_imag=randn(N,1);
    x=x_real+1i*x_imag;
    x_real_fi=cast(x_real,"like",t.x_real);
    x_imag_fi=cast(x_imag,"like",t.x_imag);
    for n = 1:N
        fprintf(id1, '%s \n', bin(x_imag_fi(n)));
        fprintf(id2, '%s \n', bin(x_real_fi(n)));
    end
    x_fi=cast(x,"like",t.x);
    [X_calculated,Xcal]=top_mex(x_real,x_imag,t,id5,id6,id7,id8,id9,id10,N);
    % [X_calculated,Xcal]=top(x_real,x_imag,t);
    for n = 1:N
        fprintf(id3, '%s \n', bin(real(X_calculated(n))));
        fprintf(id4, '%s \n', bin(imag(X_calculated(n))));
    end
    X_actual=fft((x));
    Psig = sum((abs(X_actual)).^2);
    error(seed)=abs(mean(X_actual-double(Xcal)));
    e(:,seed)=abs(X_actual-double(Xcal));
    Pnoise = sum((abs(X_actual-double(Xcal))).^2);
    SQNR(seed) = 10*log10(Psig/(Pnoise));
end
%% ploting the error
figure;
plot(x_axis,SQNR);
grid on;
xlabel('seed');
ylabel('SQNR (dB)');
title('SQNR vs Seed');
figure;
SQNR = mean(SQNR);
disp(['Mean SQNR: ', num2str(SQNR)]);
fclose(id1);
fclose(id2);
fclose(id3);
fclose(id4);
fclose(id5);
fclose(id6);
fclose(id7);
fclose(id8);
fclose(id9);
plot(x_axis,error);
grid on;
xlabel('seed');
ylabel('error');
title('Error vs Seed');
disp(['Mean Error: ', num2str(mean(error))]);
showInstrumentationResults top_mex -proposeFL -defaultDT numerictype(1,12,0)
% figure;
% plot(x_axis,e);
% grid on;
% xlabel('seed');
% ylabel('error');
% title('Error vs Seed (Detailed)');
