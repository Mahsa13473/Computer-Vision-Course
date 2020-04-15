function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary

I1_color = I1;
I2_color = I2;

if (ndims(I1) == 3)
    I1 = rgb2gray(I1);
end

if (ndims(I2) == 3)
    I2 = rgb2gray(I2);
end
%% Detect features in both images

F1 = detectSURFFeatures(I1);
F2 = detectSURFFeatures(I2);
%% Obtain descriptors for the computed feature locations

[desc1, locs1] = extractFeatures(I1, F1.Location, 'Method', 'SURF');
[desc2, locs2] = extractFeatures(I2, F2.Location, 'Method', 'SURF');

%% Match features using the descriptors

indexPairs = matchFeatures(desc1,desc2,'MatchThreshold',1.0);
locs1 = locs1(indexPairs(:,1),:);
locs2 = locs2(indexPairs(:,2),:);

%% Visualization

% fig = figure();
% showMatchedFeatures(I1_color, I2_color, locs1, locs2, 'montage');
% title('Task 4.1: matchPics better results with SURF');
% saveas(fig, '../results/4_1_better.png');

locs1 = locs1.Location;
locs2 = locs2.Location;
end

