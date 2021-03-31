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

% Definizione piano z = 1
[X,Y] = meshgrid(MIN_LIM:.2:MAX_LIM, MIN_LIM:.2:MAX_LIM);
Z = ones(size(X));
surf(X, Y, Z, 'FaceAlpha', 0.1, 'EdgeColor', 'none')

shearing = [1 0 2; 0 1 0; 0 0 1];