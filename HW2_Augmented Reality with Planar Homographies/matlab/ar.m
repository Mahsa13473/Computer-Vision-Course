% Q3.3.1
% Task 5. Creating your Augmented Reality application 

clc
clear
cv_img = imread('../data/cv_cover.jpg'); % 440x350
book_video = loadVid('../data/book.mov');
panda_video = loadVid('../data/ar_source.mov'); % 360x640x3

n_frames = length(panda_video);

output_video = VideoWriter('../results/ar.avi');
output_video.open;

% How to resize?
% (360/440)*350 = 286
% (640-286)/2 : (640-286)/2+286 -> 177:463
 
for i = 1 : n_frames
    fprintf('%d/%d\n',i,n_frames)
    panda_frame = panda_video(i).cdata(:,177:463,:);
    book_frame = book_video(i).cdata;
    [locs1, locs2] = matchPics_better(cv_img, book_frame);
    [bestH2to1, ~, ~] = computeH_ransac(locs1, locs2);
    scaled_hp_img = imresize(panda_frame, [size(cv_img,1) size(cv_img,2)]);
    book_video(i).cdata = compositeH(bestH2to1, scaled_hp_img, book_frame);
    writeVideo(output_video, book_video(i).cdata);
end
output_video.close;

