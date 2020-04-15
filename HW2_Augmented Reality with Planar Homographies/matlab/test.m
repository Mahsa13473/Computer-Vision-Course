close all;
clear;
clc;

% Create the random number stream for reproducibility
s = RandStream('mlfg6331_64'); 

%% 4.1 test matchPics.m

cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');

[locs1, locs2] = matchPics(cv_img, desk_img);
[locs1, locs2] = matchPics_better(cv_img, desk_img);

fig = figure();

%% 4.3 test computeH.m

H2to1 = computeH(locs1, locs2);

random_num_sample = 10;
random_x = randsample(s, size(cv_img,2), random_num_sample);
random_y = randsample(s, size(cv_img,1), random_num_sample);
random_cover = [random_x, random_y];

random_cover_project = inv(H2to1)*[random_cover, ones(random_num_sample,1)]';
random_cover_project = random_cover_project';
random_cover_project = random_cover_project./random_cover_project(:,3);

showMatchedFeatures(cv_img, desk_img, random_cover, random_cover_project(:,1:2), 'montage');
title('Task 4.3: Showing the corresponding locations in the second image after the homography transformation')
saveas(fig, '../results/4_3.png');

%% 4.4 test computeH_norm.m

% max
H2to1 = computeH_norm(locs1, locs2, 0); % 0 => max

random_cover_project = inv(H2to1)*[random_cover, ones(random_num_sample,1)]';
random_cover_project = random_cover_project';
random_cover_project = random_cover_project./random_cover_project(:,3);
showMatchedFeatures(cv_img, desk_img, random_cover, random_cover_project(:,1:2), 'montage');
title('Task 4.4: Showing the corresponding locations in the second image after the homography transformation with Normalization (max)')
saveas(fig, '../results/4_4_max.png');

% mean
H2to1 = computeH_norm(locs1, locs2, 1); % 1 => mean

random_cover_project = inv(H2to1)*[random_cover, ones(random_num_sample,1)]';
random_cover_project = random_cover_project';
random_cover_project = random_cover_project./random_cover_project(:,3);
showMatchedFeatures(cv_img, desk_img, random_cover, random_cover_project(:,1:2), 'montage');
title('Task 4.4: Showing the corresponding locations in the second image after the homography transformation with Normalization (mean)')
saveas(fig, '../results/4_4_mean.png');

%% 4.5 test computeH_ransac.m

[bestH2to1, inliers, best_index] = computeH_ransac(locs1, locs2);

showMatchedFeatures(cv_img, desk_img, locs1(best_index, :), locs2(best_index, :), 'montage')
title('Task 4.5: visualizing 4 point-pairs that produced the most number of inliers by RANSAC algorithm') 
saveas(fig, '../results/4_5_points.png');

showMatchedFeatures(cv_img, desk_img, locs1(inliers>0, :), locs2(inliers>0, :), 'montage')
title('Task 4.5: the inlier matches that was selected by RANSAC algorithm')
saveas(fig, '../results/4_5_inliers.png');


