% A test script using templeCoords.mat
%
% Write your code here
%

clc;
clear;

%% Load the two images and the point correspondences from someCorresp.mat
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
load('../data/someCorresp.mat');
%% Run eightpoint to compute the fundamental matrix F
F = eightpoint(pts1, pts2, M)
% displayEpipolarF(I1, I2, F);
%% Load the points in image 1 contained in templeCoords.mat 
% and run your epipolarCorrespondences on them to get the corresponding points in image 
load('../data/templeCoords.mat')
pts2 = epipolarCorrespondence(I1, I2, F, pts1);
% [coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, F);
%% Load intrinsics.mat and compute E.
load('../data/intrinsics.mat','K1', 'K2');
E = essentialMatrix(F, K1, K2)
%% Compute P1
P1 = K1*[1 0 0 0;
         0 1 0 0;
         0 0 1 0];
%% Compute P2 using camera2.m to compute the four candidates for P2
ext2_all = camera2(E);

 for i = 1:4
     P2 = K2*ext2_all(:,:,i);
     pts3d_all(:, :, i) = triangulate(P1,pts1, P2, pts2);
     positive_z(i) = length(find(pts3d_all(:,3,i)>0));

 end
 

index_max = find(positive_z == max(positive_z));
index_max = index_max(1);
pts3d = pts3d_all(:, :, index_max);
ext2 = ext2_all(:, :, index_max);

scatter3(pts3d(:, 1), pts3d(:, 2), pts3d(:, 3), 'filled')
axis('equal');

R1 = eye(3);
t1 = zeros(3,1);
R2 = ext2(:,1:3);
t2 = ext2(:,4);

% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
