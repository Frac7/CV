clear all
close all
clc

CIRCLES = 11;

shearing = [1 0 2; 0 1 0; 0 0 1];

f = figure;

hold on
axis equal

xlim([-1.5 3.5])
ylim([-1 3])
zlim([0 2])

xlabel('X')
ylabel('Y')
zlabel('Z')

% Plot origine assi
quiver3(0,0,0,1,0,0,'Color','r','autoscale','off')
quiver3(0,0,0,0,1,0,'Color','g','autoscale','off')
quiver3(0,0,0,0,0,1,'Color','b','autoscale','off')

% Definizione piano z = 1
[X,Y] = meshgrid(-1.5:.1:3.5, -1.5:.1:3.5);
Z = ones(size(X));
surf(X, Y, Z, 'FaceAlpha', 0.1, 'EdgeColor', 'none')

% Definizione circonferenza
r = 1;
theta = [-180:1:179];

fsize = size(theta);
factor = repmat([0:.1:1], fsize(2) * CIRCLES, 1);
 
X = repmat(r * cosd(theta), CIRCLES)';
Y = repmat(r * sind(theta), CIRCLES)';
Z = ones(size(X)) .* factor;
plot3(X, Y, Z, ' .b', 'MarkerSize', 3);

% Applicazione della trasformazione
X = reshape(X,[],1)';
Y = reshape(Y,[],1)';
Z = reshape(Z,[],1)';

all = [X; Y; Z];
all_shearing = shearing * all;
plot3(all_shearing(1,:), all_shearing(2,:), all_shearing(3,:), '.r', 'MarkerSize', 3);