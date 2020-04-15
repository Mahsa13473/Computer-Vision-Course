
function [filterResponses] = extractGaborResponses(I)
    [~,~,x] = size(I);
    if x == 3
        [L,A,B] = RGB2Lab(I);
    else
        L = I;
        A = I;
        B = I;
    end

    wavelength = [1 2 4 8 sqrt(2)*8];
    orientation = [0 45 90 135];
    g = gabor(wavelength,orientation);

    [H,W] = size(L);
    filterResponses = zeros(H,W,3*numel(wavelength)*numel(orientation));

    filterResponses(:,:,1:3:end) = imgaborfilt(L,g);
    filterResponses(:,:,2:3:end) = imgaborfilt(A,g);
    filterResponses(:,:,3:3:end) = imgaborfilt(B,g);
