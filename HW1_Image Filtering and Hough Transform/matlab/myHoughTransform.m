function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
     Im(Im<threshold) = 0;
    % uncomment to compare to your implementation
    % [H, thetaScale, rhoScale] = hough(Im);
%     Im = flipud(Im);
    
    % Parameterize lines in terms of theta and rho such that 
    % rho = x cos(theta) + y sin(theta)
    % 0 < theta < pi
    % -M < rho < M
    
    % M can be maximum equal to the diagonal of the image
    % sqrt(width^2 + height^2)
    [width, height] = size(Im);
    M = norm([width height]);
    % M = sqrt(img_x.^2 + img_y.^2);
    
    % Quantitize rho and theta
    rhoScale = -M:rhoRes:M;
    thetaScale = 0:thetaRes:pi;
    
    H = zeros(numel(rhoScale), numel(thetaScale));
    
    % Find indices and values of nonzero elements (find edge pixels)
    [x_index, y_index] = find(Im);

    
    % allocate space for the accumulator array and initialize to zero
      num_pixel_edge = numel(x_index);
      accumulator = zeros(num_pixel_edge, numel(thetaScale));

   % transform the image from [x,y] to [rho,theta]
    accumulator = y_index*cos(thetaScale)+x_index*sin(thetaScale);
    H = hist(accumulator, rhoScale);
    
    
end
        

















