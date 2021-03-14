clear all
close all
clc

MIN_LIM = -5;
MAX_LIM = 10;
STEP = .25;

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
L = [7 9 8];
plot3(L(1), L(2), L(3), '.r', 'MarkerSize', 12);
text(L(1) + .3, L(2) + .3, L(3) + .3, 'L');

% Definizione piano

% 1. Definizione punto nello spazio per il quale passa la retta
% che vincola l' "inclinazione" del piano rispetto a Z
line = [6 5 7];
% 2. Ricavare la matrice Z: l*x+m*y+n*z=0 -> %z=-(l*x+m*y)/n
[X, Y] = meshgrid(MIN_LIM:STEP:MAX_LIM, MIN_LIM:STEP:MAX_LIM);
Z = -(line(1) * X + line(2) * Y)/line(3);
surf(X, Y, Z, 'FaceAlpha', STEP, 'EdgeColor', 'none');

% Generazione triangoli
% -- vedere f6_line_3d --

% 1. Definizione punti
%  a. Direzione
dir = [1 1 0]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([-4 -2]);
t2 = t1 * 2;
A1 = L + t1 * dir;
A2 = L + t2 * dir;
plot3(A1(1), A1(2), A1(3), '.b', 'MarkerSize', 6);
text(A1(1) + .3, A1(2) + .3, A1(3) + .3, 'A1');
plot3(A2(1), A2(2), A2(3), '.r', 'MarkerSize', 6);
text(A2(1) + .3, A2(2) + .3, A2(3) + .3, 'A2');

%  a. Direzione
dir = [1 0 1]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([-4 -2]);
t2 = t1 * 2;
B1 = L + t1 * dir;
B2 = L + t2 * dir;
plot3(B1(1), B1(2), B1(3), '.b', 'MarkerSize', 6);
text(B1(1) + .3, B1(2) + .3, B1(3) + .3, 'B');
plot3(B2(1), B2(2), B2(3), '.r', 'MarkerSize', 6);
text(B2(1) + .3, B2(2) + .3, B2(3) + .3, 'B');

%  a. Direzione
dir = [0 1 1]; % rand?
dir = dir ./ norm(dir);
%  b. Parametro t
t1 = randi([-4 -2]);
t2 = t1 * 2;
C1 = L + t1 * dir;
C2 = L + t2 * dir;
plot3(C1(1), C1(2), C1(3), '.b', 'MarkerSize', 6);
text(C1(1) + .3, C1(2) + .3, C1(3) + .3, 'C');
plot3(C2(1), C2(2), C2(3), '.r', 'MarkerSize', 6);
text(C2(1) + .3, C2(2) + .3, C2(3) + .3, 'C');

% 2. Definizione segmenti
plot3([A1(1) B1(1) C1(1) A1(1)], [A1(2) B1(2) C1(2) A1(2)], [A1(3) B1(3) C1(3) A1(3)], '-b', 'LineWidth', 1.5);
plot3([A2(1) B2(1) C2(1) A2(1)], [A2(2) B2(2) C2(2) A2(2)], [A2(3) B2(3) C2(3) A2(3)], '-r', 'LineWidth', 1.5);



