function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
N = size(pts1,1);
pts2 = zeros(size(pts1));

patch_size = 35; % odd number
pad_size = (patch_size - 1)/2;
im1_pad = padarray(im1,[0 pad_size], 0.0, 'both');
im2_pad = padarray(im2,[0 pad_size], 0.0, 'both');

for i=1:N
    % Find epipolar line
    epipolar_line = F*[pts1(i, :), 1]';
    % Generate a set of candidate points
    x = 1:size(im2,2);
    y = round(((-epipolar_line(1)*x) - epipolar_line(3))/epipolar_line(2));
    p2 = [x' y'];
    % Extract distances between two image patches
    x = pts1(i, 1) + pad_size;
    y = pts1(i, 2) + pad_size;
    im1_patch = double(im1_pad(y - pad_size : y + pad_size, x - pad_size : x + pad_size, :));
    for j = 1:length(p2)
        x = p2(j, 1) + pad_size;
        y = p2(j, 2) + pad_size;
        im2_patch = double(im2_pad(y - pad_size : y + pad_size, x - pad_size : x + pad_size, :));
        % Manhattan distance
        dist(j) = mean(mean(mean(abs(im1_patch - im2_patch))));
    end
    index_min = find(dist == min(dist));
    pts2(i, :) = p2(index_min, :);
end
