%clear all
%close all
%clc

MIN_LIM = -15;
MAX_LIM = 20;

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

% 1. Equazione parametrica del piano
line = [1 2 3];
% 2. Ricavare la matrice Z: l*x+m*y+n*z=0 -> %z=-(l*x+m*y)/n
[Xp, Yp] = meshgrid(MIN_LIM:.1:MAX_LIM, MIN_LIM:.1:MAX_LIM);
Zp = -(line(1) * Xp + line(2) * Yp)/line(3);
surf(Xp, Yp, Zp, 'FaceAlpha', .1, 'EdgeColor', 'none');

% Definizione del punto di intersezione
L = [7 8 9];
plot3(L(1), L(2), L(3), '.r', 'MarkerSize', 12);
text(L(1) + .3, L(2) + .3, L(3) + .3, 'L');

% Generazione triangolo blu e rette -- vedere f6_line_3d --

% 1. Definizione punti
%  a. Direzione
dir1 = [0 1 2];
%  b. Parametro t
t1 = -2.5;
A = L + t1 * dir1;
plot3(A(1), A(2), A(3), '.b', 'MarkerSize', 6);
text(A(1) + .3, A(2) + .3, A(3) + .3, 'A');
% Retta
t = [MIN_LIM:.1:MAX_LIM];
Xa = L(1) + t * dir1(1);
Ya = L(2) + t * dir1(2);
Za = L(3) + t * dir1(3);
plot3(Xa, Ya, Za, '--k');

%  a. Direzione
dir2 = [1 2 0];
%  b. Parametro t
t1 = -3.25;
B = L + t1 * dir2;
plot3(B(1), B(2), B(3), '.b', 'MarkerSize', 6);
text(B(1) + .3, B(2) + .3, B(3) + .3, 'B');
% Retta
t = [MIN_LIM:.1:MAX_LIM];
Xb = L(1) + t * dir2(1);
Yb = L(2) + t * dir2(2);
Zb = L(3) + t * dir2(3);
plot3(Xb, Yb, Zb, '--k');

%  a. Direzione
dir3 = [2 0 1];
%  b. Parametro t
t1 = -1.75;
C = L + t1 * dir3;
plot3(C(1), C(2), C(3), '.b', 'MarkerSize', 6);
text(C(1) + .3, C(2) + .3, C(3) + .3, 'C');
% Retta
t = [MIN_LIM:.1:MAX_LIM];
Xc = L(1) + t * dir3(1);
Yc = L(2) + t * dir3(2);
Zc = L(3) + t * dir3(3);
plot3(Xc, Yc, Zc, '--k');

% 2. Definizione segmenti
plot3([A(1) B(1) C(1) A(1)], [A(2) B(2) C(2) A(2)], [A(3) B(3) C(3) A(3)], '-b', 'LineWidth', 1.5);

% Intersezione piano e retta
%x=t*Lx
%y=t*Ly
%z=t*Lz -> t*Lz=1 -> t=1/Lz
% in questo esempio specifico si usa il piano z = 1
% Lx, Ly, Lz:
% L è il punto da cui partono le rette
% x y e z sono coordinate del piano
% il piano è definito da 3 matrici
p = dir1 ./ dir1(3);
plot3(p(1), p(2), p(3), '.r', 'MarkerSize', 6);