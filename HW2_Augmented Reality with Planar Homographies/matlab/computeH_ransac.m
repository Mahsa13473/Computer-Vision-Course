function [ bestH2to1, inliers, best_index] = computeH_ransac(locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

% https://github.com/sadimanna/ransac/blob/master/estimateTransformRANSAC.m

%% Intialization

N_pts = length(locs1); % total number of points
s = 4; % number of correspondences
e = 0.7; % outlier ratio
p = 0.95; % probability that a point is an inlier
sigma = 20; % the distance threshold
n_iter = ceil(log10(1-p)/log10(1-(1-e)^s)); % number of iterations

threshold = 0.5;

H_RANSAC_best = [];
Error = -1;
best_index = -1;
min_dist = 10000;

%% for loop
for i=1:n_iter
    %% Random sample
    index = randsample(N_pts, s);
    locs1_pts = locs1(index,:);
    locs2_pts = locs2(index,:);
    %% Homography Matrix estimation
    H = computeH_norm(locs1_pts,locs2_pts,1);
    
    %% Error Calculation
    locs2_homo = [locs2, ones(size(locs2,1),1)];
    locs1_homo_proj = H*locs2_homo';
    locs1_proj = locs1_homo_proj./locs1_homo_proj(3,:);
    locs1_proj = locs1_proj';
    % compute distance
    dist = sqrt((locs1(:,1)-locs1_proj(:,1)).^2 + (locs1(:,2)-locs1_proj(:,2)).^2);
    dist1 = sum(dist);
    dist = dist<threshold;
    if (sum(dist)> Error) || ((dist1<min_dist) && (sum(dist)==Error)) % find the maximum inliers
        Error=sum(dist);
        H_RANSAC_best=H;
        best_index = index;
        min_dist = dist1;
    end
end

inliers=dist;
% bestH2to1 = computeH_norm(locs1(inliers>0, :), locs2(inliers>0, :),1);
bestH2to1 = double(H_RANSAC_best);

end