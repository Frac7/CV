clear all
close all
clc

MIN_LIM = -5;
MAX_LIM = 10;

f = figure;
hold on
axis equal
xlim([MIN_LIM MAX_LIM])
ylim([MIN_LIM MAX_LIM])
zlim([MIN_LIM MAX_LIM])
xlabel('X')
ylabel('Y')
zlabel('Z')

% Plot origine assi
quiver3(0,0,0,1,0,0,'Color','r','autoscale','off')
quiver3(0,0,0,0,1,0,'Color','g','autoscale','off')
quiver3(0,0,0,0,0,1,'Color','b','autoscale','off')

% Definizione piano

% 1. Equazione cartesiana del piano
n = [1 0 1];
n = n/norm(n);
a = n(1); 
b = n(2); 
c = n(3);
d = 0;
[Xp, Yp] = meshgrid(MIN_LIM:.1:MAX_LIM, MIN_LIM:.1:MAX_LIM);
Zp = (-1 / c) * ( a * Xp + b * Yp + d);
surf(Xp, Yp, Zp, 'FaceAlpha', .1, 'EdgeColor', 'none');

% Definizione del punto di intersezione
L = [7 8 9];
plot3(L(1), L(2), L(3), '.r', 'MarkerSize', 12);
text(L(1) + .3, L(2) + .3, L(3) + .3, 'L');

% Generazione triangolo blu e rette

% 1. Definizione punti
%  a. Direzione
dirA = [0 .5 1];
dirA = dirA / norm(dirA);
%  b. Parametro t
t = -2.5;
A = L + t * dirA;
plot3(A(1), A(2), A(3), '.b', 'MarkerSize', 6);
text(A(1) + .3, A(2) + .3, A(3) + .3, 'A');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
Xa = L(1) + t * dirA(1);
Ya = L(2) + t * dirA(2);
Za = L(3) + t * dirA(3);
plot3(Xa, Ya, Za, '--k');

%  a. Direzione
dirB = [.5 1 0];
dirB = dirB / norm(dirB);
%  b. Parametro t
t = -3.25;
B = L + t * dirB;
plot3(B(1), B(2), B(3), '.b', 'MarkerSize', 6);
text(B(1) + .3, B(2) + .3, B(3) + .3, 'B');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
Xb = L(1) + t * dirB(1);
Yb = L(2) + t * dirB(2);
Zb = L(3) + t * dirB(3);
plot3(Xb, Yb, Zb, '--k');

%  a. Direzione
dirC = [1 0 .5];
dirC = dirC / norm(dirC);
%  b. Parametro t
t = -1.75;
C = L + t * dirC;
plot3(C(1), C(2), C(3), '.b', 'MarkerSize', 6);
text(C(1) + .3, C(2) + .3, C(3) + .3, 'C');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
Xc = L(1) + t * dirC(1);
Yc = L(2) + t * dirC(2);
Zc = L(3) + t * dirC(3);
plot3(Xc, Yc, Zc, '--k');

% 2. Definizione segmenti
plot3([A(1) B(1) C(1) A(1)], [A(2) B(2) C(2) A(2)], [A(3) B(3) C(3) A(3)], '-b', 'LineWidth', 1.5);

% Intersezione piano e retta, prova per C
% La retta è espressa come x_i = x_iL + d_it, al variare di t
% ---
% Passaggio a forma cartesiana...
% 1. Esplicitiamo t
%  t = (L(3) + Zc) / dirC(3)
% 2. Sostituiamo
%  Xc = L(1) + ((L(3) + Zc) / dirC(3)) * dirC(1)
%  Yc = L(2) + ((L(3) + Zc) / dirC(3)) * dirC(2)
% 3. Equazioni della retta
% Xc - L(1) - ((L(3) + Zc) / dirC(3)) * dirC(1) = 0
% Yc - L(2) - ((L(3) + Zc) / dirC(3)) * dirC(2) = 0
% Il piano è espersso come ax + by + cz + d = 0
% Mettere il tutto a sistema per trovare il punto di intersezione
A = [1 0 dirC(1)/dirC(3); 0 1 dirC(2)/dirC(3); a b c];
b = [L(1) + L(3) * dirC(1) / dirC(3); L(2) + L(3) * dirC(1) / dirC(3); d];
x = A\b;
plot3(x(1), x(2), x(3), '.r');