clear;
close;
clc;

% Load an image, a CAD model cad, 2D points x and 3D points X from PnP.mat
load('../data/PnP.mat')
N = size(x, 2);

% Run estimate_pose and estimate_params
P = estimate_pose(x, X);
[K, R, t] = estimate_params(P);

% Use your estimated camera matrix P to project the given 3D points X onto the image
x_proj = P * [X; ones(1,N)];
x_proj = x_proj(1:2,:)./x_proj(3,:);

% Plot the given 2D points x and the projected 3D points on screen
figure
imshow(image,[]);
hold on
plot(x(1,:), x(2,:), 'Og', 'MarkerSize',10);
plot(x_proj(1,:), x_proj(2,:), '.k');

% Draw the CAD model rotated by your estimated rotation R on screen
N = size(cad.vertices, 1);
x = (P * [cad.vertices ones(N,1)]')';
x = x(:,1:2)./x(:,3);
X_rot = (R * cad.vertices')';
figure
trimesh(cad.faces, X_rot(:,1), X_rot(:,2), X_rot(:,3))

% Project the CAD?s all vertices onto the image
figure;
imshow(image,[]);
hold on
patch('faces', cad.faces, 'vertices' ,x, 'FaceColor', [1,0,0], 'EdgeColor', [1,0,0], 'FaceAlpha', 0.2);

