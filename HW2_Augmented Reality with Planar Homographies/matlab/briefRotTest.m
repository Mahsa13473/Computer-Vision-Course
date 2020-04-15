% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary

fig = figure();

I = imread('../data/cv_cover.jpg');
I_color = I;
if (ndims(I) == 3)
    I = rgb2gray(I);
end

%% -------------------------------BRIEF------------------------------------
%% Compute the features and descriptors

FAST = detectFASTFeatures(I);
[desc, locs] = computeBrief(I, FAST.Location);
hist_matches_BRIEF = zeros(1, 35);

for i = 1:35 
    %% Rotate image
    
    I_Rot = imrotate(I, i*10);
    %% Compute features and descriptors
   
    FAST_Rot = detectFASTFeatures(I_Rot);
    [desc_Rot, locs_Rot] = computeBrief(I_Rot, FAST_Rot.Location);
    %% Match features 
    
    indexPairs = matchFeatures(desc, desc_Rot, 'MatchThreshold', 10.0, 'MaxRatio', 0.7);
    matchedPoints = locs(indexPairs(:,1),:);
    matchedPoints_Rot = locs_Rot(indexPairs(:,2),:);
    %% Update histogram
    
    hist_matches_BRIEF(i) = size(matchedPoints_Rot, 1);
    
    %% Visualize the feature matching result at three different orientations
    
    if (i==7 || i==15 || i==31)
        showMatchedFeatures(I, I_Rot, matchedPoints, matchedPoints_Rot, 'montage');
        title(strcat('BRIEF: ', int2str(i*10), ' degree'));
        saveas(fig, strcat('../results/4_2_BRIEF',int2str(i*10),'.png'));
    end
end

%% -------------------------------SURF------------------------------------
%% Compute the features and descriptors

SURF = detectSURFFeatures(I);

% https://www.mathworks.com/help/vision/ref/extractfeatures.html
[features, validPoints] = extractFeatures(I, SURF.Location);

hist_matches_SURF = zeros(1, 35);

for i = 1:35
    %% Rotate image
    
    I_Rot = imrotate(I, i*10);
    %% Compute features and descriptors
    
    SURF_Rot = detectSURFFeatures(I_Rot);

    [features_Rot, validPoints_Rot] = extractFeatures(I_Rot, SURF_Rot.Location);
 
    %% Match features 
      
    indexPairs = matchFeatures(features, features_Rot, 'MatchThreshold', 1.0); % 'MaxRatio', 0.7
    matchedPoints = validPoints(indexPairs(:,1),:);
    matchedPoints_Rot = validPoints_Rot(indexPairs(:,2),:);
    %% Update histogram (SURF)
    
    hist_matches_SURF(i) = size(matchedPoints_Rot, 1);
    
    %% Visualize the feature matching result at three different orientations
    
    if (i==7 || i==15 || i==31)
        showMatchedFeatures(I, I_Rot, matchedPoints, matchedPoints_Rot, 'montage');
        title(strcat('SURF: ', int2str(i*10), ' degree'));
        saveas(fig, strcat('../results/4_2_SURF',int2str(i*10),'.png'));
    end
end

%% Display histogram

% uncomment if you want to check for all degress
samples = (1:35);

% sample degrees
% samples = [7, 15, 31];

bar(samples*10, hist_matches_BRIEF(samples));
xlabel('rotation angle (deg)');
ylabel('number of matched features');
title('count of matched features for each orientation using BRIEF');
saveas(fig, '../results/4_2_BRIEF_hist.png');


bar(samples*10, hist_matches_SURF(samples));
xlabel('rotation angle (deg)')
ylabel('number of matched features')
title('count of matched features for each orientation using SURF');
saveas(fig, '../results/4_2_SURF_hist.png');
