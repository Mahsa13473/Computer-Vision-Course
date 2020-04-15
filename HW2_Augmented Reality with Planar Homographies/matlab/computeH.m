function [ H2to1 ] = computeH( x1, x2 )

% https://www.mathworks.com/matlabcentral/answers/26141-homography-matrix
n = size(x1,1);
x = x1(:,1)'; y = x1(:,2)'; X = x2(:,1)'; Y = x2(:,2)';
rows0 = zeros(3, n);
rowsXY = -[X; Y; ones(1,n)];
hx = [rowsXY; rows0; x.*X; x.*Y; x];
hy = [rows0; rowsXY; y.*X; y.*Y; y];
h = [hx hy];
[U, ~, ~] = svd(h);
H2to1 = (reshape(U(:,9), 3, 3)).';
end
