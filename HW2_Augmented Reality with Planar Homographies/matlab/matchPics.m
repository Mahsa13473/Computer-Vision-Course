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

F1 = detectFASTFeatures(I1);
F2 = detectFASTFeatures(I2);
%% Obtain descriptors for the computed feature locations

[desc1, locs1] = computeBrief(I1, F1.Location);
[desc2, locs2] = computeBrief(I2, F2.Location);
%% Match features using the descriptors
% https://www.mathworks.com/help/vision/ref/matchfeatures.html?s_tid=doc_ta
indexPairs = matchFeatures(desc1,desc2,'MaxRatio', 0.7, 'MatchThreshold', 10.0);
locs1 = locs1(indexPairs(:,1),:);
locs2 = locs2(indexPairs(:,2),:);

%% Visualization

fig = figure();
showMatchedFeatures(I1_color, I2_color, locs1, locs2, 'montage');
title('Task 4.1: matchPics results');
saveas(fig, '../results/4_1.png');
end

