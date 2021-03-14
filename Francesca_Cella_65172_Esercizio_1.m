clear all
close all
clc

MIN_LIM = -5;
MAX_LIM = 10;

f = figure;
hold on
axis equal
xlim([MIN_LIM * 1.5 MAX_LIM * 1.5])
ylim([MIN_LIM * 1.5 MAX_LIM * 1.5])
zlim([MIN_LIM * 1.5 MAX_LIM * 1.5])
xlabel('X')
ylabel('Y')
zlabel('Z')

% Plot origine assi
quiver3(0,0,0,1,0,0,'Color','r','autoscale','off')
quiver3(0,0,0,0,1,0,'Color','g','autoscale','off')
quiver3(0,0,0,0,0,1,'Color','b','autoscale','off')

% Definizione del punto di intersezione
L = randi([-MIN_LIM MAX_LIM], 1, 3);
plot3(L(1), L(2), L(3), '.r', 'MarkerSize', 12);
text(L(1) + .3, L(2) + .3, L(3) + .3, 'L');

% Definizione piano

% 1. Definizione punto nello spazio per il quale passa la retta
% che vincola l' "inclinazione" del piano rispetto a Z
line = randi([0 -MIN_LIM], 1, 3);
% 2. Ricavare la matrice Z: l*x+m*y+n*z=0 -> %z=-(l*x+m*y)/n
[X, Y] = meshgrid(MIN_LIM:.25:MAX_LIM, MIN_LIM:.25:MAX_LIM);
Z = -(line(1) * X + line(2) * Y)/line(3);
surf(X, Y, Z, 'FaceAlpha', .25, 'EdgeColor', 'none');

% Generazione triangoli e rette
% -- vedere f6_line_3d --

% 1. Definizione punti
%  a. Direzione
dir = [1 1 0]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([MIN_LIM * 2 MIN_LIM]) * 0.5;
t2 = randi([MIN_LIM * 3 MIN_LIM * 2]) * 0.5;
A1 = L + t1 * dir;
A2 = L + t2 * dir;
% Triangolo blu
plot3(A1(1), A1(2), A1(3), '.b', 'MarkerSize', 6);
text(A1(1) + .3, A1(2) + .3, A1(3) + .3, 'A1');
% Triangolo rosso
plot3(A2(1), A2(2), A2(3), '.r', 'MarkerSize', 6);
text(A2(1) + .3, A2(2) + .3, A2(3) + .3, 'A2');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
X = L(1) + t * dir(1);
Y = L(2) + t * dir(2);
Z = L(3) + t * dir(3);
plot3(X, Y, Z, '--k');

%  a. Direzione
dir = [1 0 1]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([MIN_LIM * 2 MIN_LIM]) * 0.5;
t2 = randi([MIN_LIM * 3 MIN_LIM * 2]) * 0.5;
B1 = L + t1 * dir;
B2 = L + t2 * dir;
% Triangolo blu
plot3(B1(1), B1(2), B1(3), '.b', 'MarkerSize', 6);
text(B1(1) + .3, B1(2) + .3, B1(3) + .3, 'B1');
% Triangolo rosso
plot3(B2(1), B2(2), B2(3), '.r', 'MarkerSize', 6);
text(B2(1) + .3, B2(2) + .3, B2(3) + .3, 'B2');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
X = L(1) + t * dir(1);
Y = L(2) + t * dir(2);
Z = L(3) + t * dir(3);
plot3(X, Y, Z, '--k');

%  a. Direzione
dir = [0 1 1]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([MIN_LIM * 2 MIN_LIM]) * 0.5;
t2 = randi([MIN_LIM * 3 MIN_LIM * 2]) * 0.5;
C1 = L + t1 * dir;
C2 = L + t2 * dir;
% Triangolo blu
plot3(C1(1), C1(2), C1(3), '.b', 'MarkerSize', 6);
text(C1(1) + .3, C1(2) + .3, C1(3) + .3, 'C1');
% Triangolo rosso
plot3(C2(1), C2(2), C2(3), '.r', 'MarkerSize', 6);
text(C2(1) + .3, C2(2) + .3, C2(3) + .3, 'C2');
% Retta
t = [MIN_LIM * 10:.1:MAX_LIM];
X = L(1) + t * dir(1);
Y = L(2) + t * dir(2);
Z = L(3) + t * dir(3);
plot3(X, Y, Z, '--k');

% 2. Definizione segmenti
plot3([A1(1) B1(1) C1(1) A1(1)], [A1(2) B1(2) C1(2) A1(2)], [A1(3) B1(3) C1(3) A1(3)], '-b', 'LineWidth', 1.5);
plot3([A2(1) B2(1) C2(1) A2(1)], [A2(2) B2(2) C2(2) A2(2)], [A2(3) B2(3) C2(3) A2(3)], '-r', 'LineWidth', 1.5);

