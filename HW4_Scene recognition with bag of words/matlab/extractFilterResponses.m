function [filterResponses] = extractFilterResponses(I, filterBank)
    [h, w, c] = size(I);
    [L, a, b] = RGB2Lab(I(:, :, 1), I(:, :, 2), I(:, :, 3));
    I_lab = zeros(size(I), 'double');
    I_lab(:, :, 1) = L;
    I_lab(:, :, 2) = a;
    I_lab(:, :, 3) = b;
    
    filterResponses = zeros([h, w, size(filterBank, 1)*c], 'double');
    
    for i=1:size(filterBank, 1)
        filter = cell2mat(filterBank(i));
        filterResponse =  imfilter(I_lab, filter, 'same');
        filterResponses(:, :, ((i-1)*3) + 1 : ((i-1)*3) + c) =  filterResponse;
    end
end


% function [filterResponses] = extractFilterResponses(I, filterBank)
% %% convert the color space of Im from RGB to Lab
% n_filter = size(filterBank, 1);
% I = double(I);
% % for gray-scale images
% if (ndims(I)<3)
%     [L,a,b] = RGB2Lab(repmat(I, [1 1 3]));
%     % we should skip it!
% else
%     [L,a,b] = RGB2Lab(I);
%     
% end
% 
% %% apply all of the n filters on each of the 3 color channels of the input image
% filterResponses = cat(3, repmat(L, 1,1,n_filter), repmat(a, 1,1,n_filter), repmat(b, 1,1,n_filter));
% filters = repmat(filterBank, 3, 1);
% 
% for i = 1: 3*n_filter
%     filterResponses(:,:,i) = conv2(filterResponses(:,:,i), filters{i}, 'same');
% end
% 
% filterResponses=double(filterResponses); 
% 
% end



