% Satelliten Navigation Uebung 1 
% Ziqing Yu 3218051
% 30/04/2021

%% Initialisierung
clc
close all
clearvars

a = [1.03; 1.54];
Q = [5.34, 3.84;
      3.84,2.80];
%% Aufgabe 1   
% a
% Einfaches Runden
a1 = round(a);

% Bootstrapping
a2(1) = round(a(1));
a2(2) = round(a(2) - Q(1,2) / Q(1,1) * (a2(1) - a(1)));

% b 
Qi = Q;
Z = eye(2);
Zi = eye(2);
alpha_i = 1;
while alpha_i ~= 0
    Z = Zi * Z;
    alpha_i = -round(Qi(1,2) / Qi(1,1));
    Zi = [alpha_i,1;1,0]
    Qi = Zi * Qi * Zi';
end

z = Z * a;
Qz = Z * Q * Z';

% Korrelation
% vor
k_vor = Q(1,2) / sqrt(Q(1,1)* Q(2,2));
% nach
k_nach = Qz(1,2) / sqrt(Qz(1,1)* Qz(2,2));

% einfach Runden
z_dach1 = round(z);
a3 = inv(Z) * z_dach1;

% Bootstrapping
z_dach2(1) = round(z(1));
z_dach2(2) = round(z(2) - Qz(1,2) / Qz(1,1) * (z_dach2(1) - z(1)));
a4 = inv(Z) * z_dach2';

% unimodulare pruefen
test = det(Z);

%% Aufgabe 2
% load data
addpath(genpath(pwd))
load('amb10.mat')

% aus demo kopiert
[a_ILS,sqnorm]                    = LAMBDA(a,Q,1,'ncands',2);
[a_ILS2,sqnorm2]                  = LAMBDA(a,Q,2,'ncands',2);
[a_R]                             = LAMBDA(a,Q,3);
[a_B]                             = LAMBDA(a,Q,4);
 
diff_ILS_R = a_ILS2(:,1) - a_R;
diff_ILS_B = a_ILS2(:,1) - a_B;

% 
test_r = sqnorm(1) / sqnorm(2);
test_r2 = sqnorm2(1) / sqnorm2(2);

%% Aufgabe 3
% mit F9 kann man nur diesen Block ausfuehren
n = 40;
t = zeros(n,1);
for i = 1:n
    tic
    a = rand([i,1]);
    Q = rand(i);
    Q = Q * Q'; % damit Q symmetrisch ist
    [a_ILS,sqnorm] = LAMBDA(a,Q,1,'ncands',2);
    toc
    t(i) = toc;
end

x = 1:40;
x = x';
ft = fittype(@(c,k,x)c*k.^x);
f = fit(x,t, ft,'StartPoint', [1 1]);

figure
hold on
plot(x,t)
plot(f,x,t)
xlabel('Anzahl Elementen')
ylabel('Rechenzeit (s)')