clear all
close all
clc

% Define images to process
imageFileNames = {'.\CameraCalibration\Image1.png',...
    '.\CameraCalibration\Image2.png',...
    '.\CameraCalibration\Image3.png',...
    '.\CameraCalibration\Image4.png',...
    '.\CameraCalibration\Image5.png',...
    '.\CameraCalibration\Image6.png',...
    '.\CameraCalibration\Image7.png',...
    '.\CameraCalibration\Image8.png',...
    '.\CameraCalibration\Image9.png',...
    '.\CameraCalibration\Image10.png',...
    '.\CameraCalibration\Image11.png',...
    '.\CameraCalibration\Image12.png',...
    '.\CameraCalibration\Image13.png',...
    '.\CameraCalibration\Image14.png',...
    '.\CameraCalibration\Image15.png',...
    '.\CameraCalibration\Image16.png',...
    '.\CameraCalibration\Image17.png',...
    '.\CameraCalibration\Image18.png',...
    '.\CameraCalibration\Image19.png',...
    '.\CameraCalibration\Image20.png',...
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

f = figure;

photos = size(imageFileNames);
photos = photos(2);

for i = 1:photos
    imshow(imageFileNames{i})
    hold on

    imgCube = worldToImage(cameraParams,R(:,:,i),t(i,:), worldCube);
    plot(imgCube(:,1), imgCube(:,2), '-y', 'LineWidth', 1.5);
    %saveas(f, sprintf('./Result/%d.png',i))
    pause
end