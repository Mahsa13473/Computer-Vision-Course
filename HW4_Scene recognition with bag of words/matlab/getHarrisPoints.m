function points = getHarrisPoints(I, alpha, k)
w = 3; % windows size
% convert to grayscale
if(ndims(I)==3)
    I = rgb2gray(I); 
else
     I = rgb2gray(I);
end
   
sigma = 1;
h_size = 2 * ceil(3 * sigma) + 1;
h = fspecial('gaussian', h_size, sigma);
% Remove HF noise
I = conv2(I, h, 'same');

    
% compute the covariance matrix for each pixel
h_sobel = fspecial('sobel'); % respond to horizontal lines

I_x = conv2(I, h_sobel', 'same');
I_y = conv2(I, h_sobel, 'same');


I_xy = I_x .* I_y;
I_xx = I_x .* I_x;
I_yy = I_y .* I_y;

filter_window = ones([w, w], 'double');

M_xx = conv2(I_xx, filter_window, 'same');
M_yy = conv2(I_yy, filter_window, 'same');
M_xy = conv2(I_xy, filter_window, 'same');

% compute the response function
R = (M_xx .* M_yy) - (M_xy .^ 2) - k * (( M_xx + M_yy ) .^ 2);

% NMS
regionalMaxImage = imregionalmax(R, 8);
R=R.*regionalMaxImage;

% find alpha maximum
[~,index_max] = maxk(R(:),alpha);
[y, x] = ind2sub(size(I), index_max);
points = [y, x];

end
