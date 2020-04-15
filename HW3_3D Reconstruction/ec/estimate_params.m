function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.
M = P(1:3, 1:3);
P = sign(det(M))*P;
% Compute camera center
[~, ~, V] = svd(P);
c = V(:, end);
c = c/c(end);
c = c(1:3, :);
% Compute the intrinsic K and rotation R by using QR decomposition
[Q,R] = qr(rot90(M,3));
K = rot90(R,2)';
R = rot90(Q);
T = diag(sign(diag(K)));
R = T * R;
K = K * T;
K = K/K(end, end);
% Compute the translation by t = ?Rc
t = -R*c;