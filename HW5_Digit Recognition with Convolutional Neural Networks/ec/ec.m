clc;
clear;
close;

% 1. Classify each pixel as foreground or background pixel by performing simple operations like thresholding.
% 2. Find connected components and place a bounding box around each character. You can use a matlab built-in function to do this.
% 3. Take each bounding box, pad it if necessary and resize it to 28×28 and pass it through the network.

directory = '../images/';
imagefiles = dir('../images/image*');      
nfiles = length(imagefiles);    % Number of files found

layers = get_lenet();
load lenet.mat


for i=1:nfiles
   current_filename = strcat(directory, imagefiles(i).name);
   current_img = imread(current_filename);

    img = current_img;
    treshold = 0.6;

    if size(img, 3)>1
           img = rgb2gray(img);
    end

    % scale image to 0, 1
    img = double(img)/255;
    % img = 1.0 - img;

    %% Classify each pixel as foreground or background pixel by performing simple operations like thresholding.
    img = img>treshold;
    img = 1.0 - img;

    %% Find connected components and place a bounding box around each character. You can use a matlab built-in function to do this.

    CC = bwconncomp(img);

    figure;
    imshow(current_img);
    hold on;
    
    for i=1:CC.NumObjects

        digit_img = zeros(size(img));
        digit_img(CC.PixelIdxList{i}) = 1;

        verticalProfile = any(digit_img, 2);
        horizontalProfile = any(digit_img, 1);

        % Find what index the bounding box is at
        topRow = find(verticalProfile, 1, 'first');
        bottomRow = find(verticalProfile, 1, 'last');
        leftCol = find(horizontalProfile, 1, 'first');
        rightCol = find(horizontalProfile, 1, 'last');

        % Crop it out of the original
        digit_img = digit_img(topRow:bottomRow, leftCol:rightCol);

        % add extra pad for become square shape
        [~, idx] = max([size(digit_img, 1), size(digit_img, 2)]);
        pad_size1 = floor((size(digit_img, idx) - size(digit_img, 1))/2);
        pad_size2 = floor((size(digit_img, idx) - size(digit_img, 2))/2);

        extra_pad = floor(size(digit_img, idx)*0.15);
        digit_img = padarray(digit_img,[pad_size1+extra_pad pad_size2+extra_pad],0,'both');
        
        digit_img = digit_img';
        digit_img = imresize(digit_img,[28, 28]);
        
        % flatten  current image
        flat_digit_img = reshape(digit_img, 28*28, 1);
        % change batch size from 100 to 1
        layers{1}.batch_size = 1;
    
        [output, Pred] = convnet_forward(params, layers, flat_digit_img);
        [~, idx] = max(Pred);
        pred_label = idx-1;
       
        digit_img_org = current_img(topRow:bottomRow, leftCol:rightCol);
        % imshow(digit_img_org);
       
        rectangle('Position',[leftCol, topRow, rightCol-leftCol, bottomRow-topRow],'EdgeColor','b','LineWidth',1 );
        % draw bounding box and prediction label
        H = text(floor((leftCol+rightCol)/2), topRow-5, num2str(pred_label), 'Color', 'red', 'FontSize', 20);
       
    end
end

