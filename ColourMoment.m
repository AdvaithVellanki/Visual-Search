%Computes the Descriptor for each image as moments of colour
%distributions such as mean, standard deviations and skewness

function CM=ColourMoment(img)
% Separate the color channels
redChannel = img(:, :, 1);
greenChannel = img(:, :, 2);
blueChannel = img(:, :, 3);

% Calculate the moments for each color channel
meanRed = mean(redChannel(:));
meanGreen = mean(greenChannel(:));
meanBlue = mean(blueChannel(:));

stdRed = std(double(redChannel(:)));
stdGreen = std(double(greenChannel(:)));
stdBlue = std(double(blueChannel(:)));

skewRed= skewness(double(redChannel(:)));
skewGreen = skewness(double(greenChannel(:)));
skewBlue = skewness(double(blueChannel(:)));

% Create a Color Moments descriptor vector
CM = [meanRed, meanGreen, meanBlue,stdRed, stdGreen, stdBlue, skewRed, skewGreen, skewBlue]; % 
return;