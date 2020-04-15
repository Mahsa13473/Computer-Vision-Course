clc;
clear;
close;

directory = '../images/real_world/';
imagefiles = dir('../images/real_world/*.png');      
nfiles = length(imagefiles);    % Number of files found

layers = get_lenet();
load lenet.mat

figure;
for i=1:nfiles
   current_filename = strcat(directory, imagefiles(i).name);
   current_image = imread(current_filename);
   % convert to grayscale
   if size(current_image, 3)>1
       current_image = rgb2gray(current_image);
   end
    current_image = current_image';
   % resize to 28x28
   current_image = imresize(current_image,[28, 28]);
   % scale image to 0, 1
   current_image = 1.0 - (double(current_image)/255);
   % flatten  current image
   flat_current_image = reshape(current_image, 28*28, 1);
   % change batch size from 100 to 1
   layers{1}.batch_size = 1;

   [output, Pred] = convnet_forward(params, layers, flat_current_image);
   gt_label = imagefiles(i).name;
   
   [~, idx] = max(Pred);
   pred_label = idx-1;
   
   subplot(1, nfiles, i);
   imshow(current_filename);
   title(pred_label);
   
end
 