% https://github.com/dipsywong98

function [h] = extractHOGResponse(I, precision)
n = 360/precision;
d = size(I, 3);

if d == 1
    L = I;
    A = I;
    B = I;
else
    [L, A, B] = RGB2Lab(I);
end
N = 3*n;
h = zeros(1,N);
h(1, 1:3:N) = hog(L,precision);
h(1, 2:3:N) = hog(A,precision);
h(1, 3:3:N) = hog(B,precision);
end


% precision: size of interval in degree
function [h] = hog(I, precision)
    n = 360/precision;
    I = double(I)/double(max(I(:)));
    [Ix, Iy] = gradient(I);
    D = mod(floor((atan2(Iy,Ix))/pi*180/precision), n)+1;
    h = zeros(1, n);
    for i = 1:n
        h(1, i) = sum(sum(D == i));
    end
    [H,W] = size(I);
    h = h/(H*W);
end