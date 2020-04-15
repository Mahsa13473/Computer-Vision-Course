function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]

N = size(X,2);
X = [X; ones(1,N)];

A = [];
for i = 1:N
    A = [A;[X(:,i)', zeros(1,4), -x(1,i)*X(:,i)'; zeros(1,4), X(:,i)', -x(2,i)*X(:,i)']];
end
[~,~,V] = svd(A);

P = reshape(V(:,end),4,3)';
end

