clc;
clear;
clear all ;
% Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');
[rectIL, rectIR, bbL, bbR] = warp_stereo(im1, im2, M1, M2);

maxDisp = 550; % 550; % 20; 
windowSize = 3;

dispM = get_disparity(rectIL, rectIR, maxDisp, windowSize);
% dispM = get_disparity(im1, im2, maxDisp, windowSize);

% --------------------  get depth map

depthM = get_depth(dispM, K1n, K2n, R1n, R2n, t1n, t2n);

% --------------------  Display

% figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;
% title('Disparity Map')
% figure; imagesc(depthM.*(im1>40)); colormap(gray); axis image;
% title('Depth Map')

figure; imagesc(dispM.*(rectIL>40)); colormap(gray); axis image;
title('Disparity Map')
figure; imagesc(depthM.*(rectIL>40)); colormap(gray); axis image;
title('Depth Map')







