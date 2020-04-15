function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

%% Normalize points and un-normalize F
N = length(pts1);

% use this if you want to normalize (not just scaling)
% centroid1 = mean(pts1);
% centroid2 = mean(pts2);
% 
% norm_mat1 = [sqrt(2)/M 0 -sqrt(2)/M*centroid1(1);
%             0 sqrt(2)/M -sqrt(2)/M*centroid1(2);
%             0 0 1];
%         
% norm_mat2 = [sqrt(2)/M 0 -sqrt(2)/M*centroid2(1);
%             0 sqrt(2)/M -sqrt(2)/M*centroid2(2);
%             0 0 1];
%         
% homo_pts1 = [pts1 ones(N,1)]';
% homo_pts2 = [pts2 ones(N,1)]';
% pts1_norm = (norm_mat1 * homo_pts1)';
% pts2_norm = (norm_mat2 * homo_pts2)';

pts1_norm = pts1./M;
pts2_norm = pts2./M;
T = [1/M,0,0;0,1/M,0;0,0,1];
%% Matrix A
x1 = pts1_norm(:, 1);
y1 = pts1_norm(:, 2);
x2 = pts2_norm(:, 1);
y2 = pts2_norm(:, 2);
A = [x2 .* x1, x2 .* y1, x2, y2 .* x1, y2 .* y1, y2, x1, y1, ones(N, 1)];
%% Estimating F
[~, ~, V] = svd(A);
F = reshape(V(:,9),3,3)';
%% Enforce the rank 2 condition by finding the SVD of A
[U, S, V] = svd(F);
% F = U(:, 1) * S(1,1) * transpose(V(:, 1)) + U(:, 2) * S(2,2) * transpose(V(:, 2));
S(end, end) = 0;
F = U*S*V';
%% Refine F by using local minimization
F = refineF(F, pts1_norm, pts2_norm);
%% Unscale
F = T'*F*T;
% F = norm_mat2' * F * norm_mat1;
end