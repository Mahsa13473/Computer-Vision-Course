function [H2to1] = computeH_norm(x1, x2, flag)
% Homography Normalization
%% Compute centroids of the points

centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid

S1 = [1, 0, -centroid1(1); 0, 1, -centroid1(2); 0, 0, 1];
S2 = [1, 0, -centroid2(1); 0, 1, -centroid2(2); 0, 0, 1];

n = size(x1,1);
x1_shift = S1 * [x1 ones(n, 1)]';
x2_shift = S2 * [x2 ones(n, 1)]';

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
%% similarity transform 1

if(flag)
    scale1 = sqrt(2)./(mean(sqrt(sum(x1_shift(1:2,:).^2,1)))); % mean
else
    scale1 = sqrt(2)./(max(sqrt(sum(x1_shift(1:2,:).^2,1)))); % max
end

T1 = [scale1, 0, 0; 0, scale1, 0; 0, 0, 1];
x1_shift_normalize = T1 * x1_shift;
T1 = T1*S1;

%% similarity transform 2

if(flag)
    scale2 = sqrt(2)./(mean(sqrt(sum(x2_shift(1:2,:).^2,1)))); % mean
else
    scale2 = sqrt(2)./(max(sqrt(sum(x2_shift(1:2,:).^2,1)))); % max
end

T2 = [scale2, 0, 0; 0, scale2, 0; 0, 0, 1];
x2_shift_normalize = T2 * x2_shift;
T2 = T2*S2;

%% Compute Homography
H = computeH(x1_shift_normalize(1:2,:)', x2_shift_normalize(1:2,:)');
%% Denormalization

H2to1 = inv(T1)*H*(T2);

end
