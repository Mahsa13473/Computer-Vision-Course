function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

N = size(pts1,1);
pts3d = zeros(N,4);
% error = zeros(N,1);
%% Triangulation
for i=1:1:N
    x1 = pts1(i,1);
    y1 = pts1(i,2);
    x2 = pts2(i,1);
    y2 = pts2(i,2);
    
    A = [y1.*P1(3,:)-P1(2,:);
        P1(1,:)-x1.*P1(3,:);
        y2.*P2(3,:)-P2(2,:);
        P2(1,:)-x2.*P2(3,:)];
    
    [~,~,V] = svd(A);
    pt3d = V(:,end);
    pt3d = pt3d/pt3d(end); 
    pts3d(i,:) = pt3d';
    
%     pts3d_project_to2 = P2*pts3d(i,:)';
%     pts3d_project_to2 = pts3d_project_to2./pts3d_project_to2(end);   
%     error(i,1) = pdist2([x2,y2],pts3d_project_to2(1:2)','euclidean');

end

% total_error = mean(error)
%% Calculating reprojection error
reprojected_pts1 = P1*pts3d';
reprojected_pts1 = reprojected_pts1./reprojected_pts1(end, :);
reprojected_pts1 = reprojected_pts1';
error1 = sum(sqrt(sum(pts1 - reprojected_pts1(:, 1:2))'.^2))/size(pts1,1)

reprojected_pts2 = P2*pts3d';
reprojected_pts2 = reprojected_pts2./reprojected_pts2(end, :);
reprojected_pts2 = reprojected_pts2';
error2 = sum(sqrt(sum(pts2 - reprojected_pts2(:, 1:2))'.^2))/size(pts2,1)
end
 