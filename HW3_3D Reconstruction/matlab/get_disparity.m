function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
pad_size = (windowSize-1)/2;
mask = ones([windowSize, windowSize], 'double');
im1pad = padarray(im1,[pad_size pad_size], 0, 'both');
im2pad = padarray(im2,[pad_size pad_size+maxDisp], 0, 'both');
dispM = zeros(size(im1), 'double');


for y=1:size(im1, 1)
    for x=1:size(im1, 2)
        if im1(y,x)>0
            im1_patch = im1pad(y : y + windowSize-1, x : x + windowSize-1);
            for d=0:maxDisp
                im2_patch = im2pad(y : y + windowSize-1, x + maxDisp-d : x + maxDisp-d + windowSize-1);
                err = (abs(im1_patch-im2_patch)).^2;
                distance(d+1) = sum(err(:));
            end
            index_min = find(distance == min(distance));
            index_min = index_min(1); % find the first one
            dispM(y, x) = index_min-1; %+ maxDisp -1;
        end
    end
end



% pad_size = (windowSize-1)/2;
% mask = ones([windowSize, windowSize], 'double');
% im1pad = padarray(im1,[pad_size pad_size], 0);
% im2pad = padarray(im2,[pad_size pad_size+maxDisp], 0);
% dispM = zeros(size(im1), 'double');
% for y=1:size(im1, 1)
%     for x=1:size(im1, 2)
%         im1_patch = im1pad(y : y + windowSize-1, x : x + windowSize-1);
%         im2_patch = im2pad(y : y + windowSize-1, x : x + maxDisp + windowSize-1);
%         % 'valid' ? Return only parts of the convolution that are computed without zero-padded edges
%         s1 = conv2(im1_patch, mask, 'valid');
%         s2 = conv2(im2_patch, mask, 'valid');
%         d = (s2-s1).^2;
%         [~, index] = min(d);
%         dispM(y, x) = (maxDisp-index -1);
%     end
% end


