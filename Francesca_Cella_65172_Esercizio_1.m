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
n = [.5 0 1];
a = n(1); 
b = n(2); 
c = n(3);
d = 0;
[Xp, Yp] = meshgrid(MIN_LIM:.1:MAX_LIM, MIN_LIM:.1:MAX_LIM);
Zp = (-1 / c) * ( a * Xp + b * Yp + d);
surf(Xp, Yp, Zp, 'FaceAlpha', .1, 'EdgeColor', 'none');

% Definizione del punto di intersezione
L = [9 8 7];
plot3(L(1), L(2), L(3), '.r', 'MarkerSize', 12);
text(L(1) + .3, L(2) + .3, L(3) + .3, 'L');

% Generazione triangolo blu e rette

% 1. Definizione punti
%  a. Direzione
dirA = [0 1 1];
%  b. Parametro t
t = -3.5;
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
dirB = [1 .75 1];
%  b. Parametro t
t = -4.25;
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
dirC = [.5 0 .75];
%  b. Parametro t
t = -2.75;
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

% Intersezione piano e retta
% La retta è espressa come x_i = x_iL + d_it, al variare di t
% Passaggio a forma cartesiana...
% 1. Esplicitiamo t
%  t = (-L(3) + Zc) / dirC(3)
% Quindi in tutte le rette il coeff di Zc è c / dirC(3)
% 2. Sostituiamo
%  Xc = L(1) + ((-L(3) + Zc) / dirC(3)) * dirC(1)
%  Yc = L(2) + ((-L(3) + Zc) / dirC(3)) * dirC(2)
% 3. Equazioni della retta
%  Xc - L(1) - ((-L(3) + Zc) / dirC(3)) * dirC(1) = 0
%  Yc - L(2) - ((-L(3) + Zc) / dirC(3)) * dirC(2) = 0
% Il piano è espersso come ax + by + cz + d = 0

coeffp = [a b c];
knownp = [-d];

coeff = [1 0 -dirA(1)/dirA(3); 0 1 -dirA(2)/dirA(3); coeffp];
known = [(-L(3)*dirA(1))/dirA(3) + L(1); (-L(3)*dirA(2))/dirA(3) + L(2); knownp];
pA = coeff\known;

coeff = [1 0 -dirB(1)/dirB(3); 0 1 -dirB(2)/dirB(3); coeffp];
known = [-L(3)*dirB(1)/dirB(3) + L(1); -L(3)*dirB(2)/dirB(3) + L(2); knownp];
pB = coeff\known;

coeff = [1 0 -dirC(1)/dirC(3); 0 1 -dirC(2)/dirC(3); coeffp];
known = [-L(3)*dirC(1)/dirC(3) + L(1); -L(3)*dirC(2)/dirC(3) + L(2); knownp];
pC = coeff\known;

plot3(pA(1), pA(2), pA(3), '.r', 'MarkerSize', 6);
text(pA(1) + .3, pA(2) + .3, pA(3) + .3, 'A1');
plot3(pB(1), pB(2), pB(3), '.r', 'MarkerSize', 6);
text(pB(1) + .3, pB(2) + .3, pB(3) + .3, 'B1');
plot3(pC(1), pC(2), pC(3), '.r', 'MarkerSize', 6);
text(pC(1) + .3, pC(2) + .3, pC(3) + .3, 'C1');

plot3([pA(1) pB(1) pC(1) pA(1)], [pA(2) pB(2) pC(2) pA(2)], [pA(3) pB(3) pC(3) pA(3)], '-r', 'LineWidth', 1.5);