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

% Definizione del punto di intersezione
L = [9 9 9];
plot3(L(1), L(2), L(3), '.r', 'MarkerSize', 12);
text(L(1) + .3, L(2) + .3, L(3) + .3, 'L');

% Definizione piano

% 1. Definizione punto nello spazio per il quale passa la retta che vincola l' "inclinazione" del piano rispetto a Z (da spiegare meglio)
line = [1 1 1];
% 2. Ricavare la matrice Z: l*x+m*y+n*z=0 -> %z=-(l*x+m*y)/n
[X, Y] = meshgrid(MIN_LIM:.1:MAX_LIM, MIN_LIM:.1:MAX_LIM);
Z = -(line(1) * X + line(2) * Y)/line(3);
surf(X, Y, Z, 'FaceAlpha', .1, 'EdgeColor', 'none');

% Generazione triangolo blu e rette -- vedere f6_line_3d --

% 1. Definizione punti
%  a. Direzione
dir = [1 .75 .25]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([MIN_LIM * 2 MIN_LIM]) * 0.5;
A = L + t1 * dir;
plot3(A(1), A(2), A(3), '.b', 'MarkerSize', 6);
text(A(1) + .3, A(2) + .3, A(3) + .3, 'A');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
X = L(1) + t * dir(1);
Y = L(2) + t * dir(2);
Z = L(3) + t * dir(3);
plot3(X, Y, Z, '--k');

%  a. Direzione
dir = [1 .25 1]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([MIN_LIM * 2 MIN_LIM]) * 0.5;
B = L + t1 * dir;
plot3(B(1), B(2), B(3), '.b', 'MarkerSize', 6);
text(B(1) + .3, B(2) + .3, B(3) + .3, 'B');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
X = L(1) + t * dir(1);
Y = L(2) + t * dir(2);
Z = L(3) + t * dir(3);
plot3(X, Y, Z, '--k');

%  a. Direzione
dir = [.5 1 .75]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([MIN_LIM * 2 MIN_LIM]) * 0.5;
C = L + t1 * dir;
plot3(C(1), C(2), C(3), '.b', 'MarkerSize', 6);
text(C(1) + .3, C(2) + .3, C(3) + .3, 'C');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
X = L(1) + t * dir(1);
Y = L(2) + t * dir(2);
Z = L(3) + t * dir(3);
plot3(X, Y, Z, '--k');

% 2. Definizione segmenti
plot3([A(1) B(1) C(1) A(1)], [A(2) B(2) C(2) A(2)], [A(3) B(3) C(3) A(3)], '-b', 'LineWidth', 1.5);

