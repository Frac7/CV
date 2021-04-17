clear all
close all
clc

% Define images to process
imageFileNames = {'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image1.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image2.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image3.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image4.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image5.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image6.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image7.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image8.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image9.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image10.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image11.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image12.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image13.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image14.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image15.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image16.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image17.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image18.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image19.png',...
    'C:\Users\Francesca\Documents\MATLAB\CV\CameraCalibration\Image20.png',...
    };
% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 25;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% Calibrare una fotocamera tramite l'app Camera Calibrator fornita da Matlab.
% Utilizzare i parametri intrinseci ed estrinseci ottenuti per sovraimporre un cubo al pattern di calibrazione.

% Proiezione dal mondo alla telecamera:
% cameraParams contiene i parametri intrinseci ed estrinseci
% - parametri estrinseci
%   - TranslationVectors
%   - RotationMatrices
% - parametri intrinseci (IntrinsicMatrix)
%   - lunghezza focale
%   - punto principale del piano della camera
%   - dimensione dei pixel in mm
%   - parametri di distorsione

% imagePoints contiene 54 punti di intersezione, ciascuno dei quali è
% rappresentato da 2 coordinate, per tutte e 20 le immagini (54 x 2 x 20)
% worldPoints contiene i 54 punti di intersezioni, ciascuno dei quali è
% rappresentato da 2 coordinate

R = cameraParams.RotationMatrices;
t = cameraParams.TranslationVectors;

z = zeros(size(worldPoints,1));
worldPoints = [worldPoints z];

edge = 75;

a = [0 0 0];
b = [0 edge 0];
c = [edge edge 0];
d = [edge 0 0];

factor = [0 0 edge];

e = a + factor;
f = b + factor;
g = c + factor;
h = d + factor;

worldCube = [a; b; c; d; a; e; f; g; h; e; h; d; c; g; f; b];

figure

photos = size(imageFileNames);
photos = photos(2);

for i = 1:photos
    imshow(imageFileNames{i})
    hold on

    imgCube = worldToImage(cameraParams,R(:,:,i),t(i,:), worldCube);
    plot(imgCube(:,1), imgCube(:,2), '-y', 'LineWidth', 1.5);
    pause
end