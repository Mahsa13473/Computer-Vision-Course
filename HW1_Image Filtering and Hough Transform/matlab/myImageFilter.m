function [img1] = myImageFilter(img0, h)

    % uncomment to compare to your implementation
    % img1 = conv2(img0, h);

    [img_x, img_y] = size(img0);

    % mirror the filter
    h_rot = rot90(h,2);
    [h_x, h_y] = size(h_rot);


    % padding input image by repeating border elements of array
    center = floor((size(h)-1)/2);
    pad_img0 = padarray(img0,[center(1), center(2)],'replicate');
    % or zero padding
    % pad_img0 = padarray(img0,[center(1), center(2)],0,'both');

    % compute convolution by vectorization
    % Matrix multiplication instead of loops by columnizing
    img_col = im2col(pad_img0, [h_x, h_y]);
    h_col = h_rot(:);
    h_col_rep= repmat(h_col, [1,size(img_col,2)]);
    out = sum(img_col .* h_col_rep);
    img1 = reshape(out, [img_x, img_y]);


    % % compute convolution without vectorization by for loop
    % img1 = zeros(img_x , img_y);
    % 
    % for x = 1 : img_x
    %     for y = 1 : img_y
    %         for i = 1 : h_x
    %             for j = 1 : h_y
    %                 img1(x, y) = img1(x, y) + (pad_img0(i + x - 1, j + y - 1) * h(i, j));
    %             end
    %         end
    %     end
    % end

end
