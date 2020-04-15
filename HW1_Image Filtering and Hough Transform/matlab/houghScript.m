clear;

datadir     = '../data';    %the directory containing the images % change it to '../ec/images' for ec
resultsdir  = '../results'; %the directory for dumping results % change it to '../ec/results' for ec

%parameters
sigma     = 2;
threshold = 0.13;
rhoRes    = 2;
thetaRes  = pi/90;
nLines    = 50;
%end of parameters

imglist = dir(sprintf('%s/*.jpg', datadir));

for i = 1:numel(imglist)
    
    %read in images%
    [path, imgname, dummy] = fileparts(imglist(i).name);
    img = imread(sprintf('%s/%s', datadir, imglist(i).name));
    
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end
    
    img = double(img) / 255;
    
      % ________________________ Task2.1: Convolution _______________________
    
%      h = [0 -1 0;
%          -1 4 -1;
%          0 -1 0];
%     
%      h = ones(11)/121;
%      h =fspecial('gaussian',11,4);
%    
%     
%      [img1] = myImageFilter(img, h);
%      fname = sprintf('%s/Convolution/Convolution_%s.png',resultsdir, imgname);
%      imwrite(img, fname);
      
      %actual Hough line code function calls%
      
      % ______________________ Task2.2: Edge Detection ______________________
      
      [Im] = myEdgeFilter(img, sigma);   
    
      % ______________________ Task2.3: Hough Transform _____________________
      
      [H,rhoScale,thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes);
     
      % ______________________ Task2.4: Finding Lines _______________________
         
         [rhos, thetas] = myHoughLines(H, nLines);

      
     % ________ Task2.5: Fitting line segments for visualization ___________    
       lines = houghlines(Im>threshold, 180*(thetaScale/pi), rhoScale, [rhos,thetas],'FillGap',5,'MinLength',10);

    
    %everything below here just saves the outputs to files%
    % fname = sprintf('%s/%s_00img.png', resultsdir, imgname);
    % imwrite(img, fname);
    fname = sprintf('%s/%s_01edge.png', resultsdir, imgname);
    imwrite(sqrt(Im/max(Im(:))), fname);
    fname = sprintf('%s/%s_02threshold.png', resultsdir, imgname);
    imwrite(Im > threshold, fname);
    fname = sprintf('%s/%s_03hough.png', resultsdir, imgname);
    imwrite(H/max(H(:)), fname);
    fname = sprintf('%s/%s_04lines.png', resultsdir, imgname);
    
%     % visualization for peaks finding
%     Image = H/max(H(:));
%     imshow(Image*5);
%     hold on;
%     plot(thetas, rhos, 'ro', 'MarkerSize', 2);
    
    
    img2 = img;
    for j=1:numel(lines)
       img2 = drawLine(img2, lines(j).point1, lines(j).point2); 
    end  
    
    imwrite(img2, fname);
end
    
