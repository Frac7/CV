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
L = [7 8 9];
plot3(L(1), L(2), L(3), '.r', 'MarkerSize', 12);
text(L(1) + .3, L(2) + .3, L(3) + .3, 'L');
% Definizione piano
% 1. Definizione punto nello spazio per il quale passa la retta
% che vincola l' "inclinazione" del piano rispetto a Z
line = [1 2 3];
% 2. Ricavare la matrice Z: l*x+m*y+n*z=0 -> %z=-(l*x+m*y)/n
[X, Y] = meshgrid(MIN_LIM:STEP:MAX_LIM, MIN_LIM:STEP:MAX_LIM);
Z = -(line(1) * X + line(2) * Y)/line(3);
surf(X, Y, Z, 'FaceAlpha', STEP, 'EdgeColor', 'none');
% Generazione triangolo blu
% 1. Definizione punti
A = [4 5 6];
plot3(A(1), A(2), A(3), '.b', 'MarkerSize', 6);
B = [5 6 4];
plot3(B(1), B(2), B(3), '.b', 'MarkerSize', 6);
C = [6 4 5];
plot3(C(1), C(2), C(3), '.b', 'MarkerSize', 6);
% 2. Definizione segmenti
plot3(A, B, C, '-b', 'LineWidth', 1.5);
plot3(C, A, B, '-b', 'LineWidth', 1.5);
% Generazione triangolo rosso



