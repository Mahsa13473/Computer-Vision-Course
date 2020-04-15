function [rhos, thetas] = myHoughLines(H, nLines)
    % uncomment to compare to your implementation
%     peaks = houghpeaks(H, nLines);
%     rhos = peaks(:,1);
%     thetas = peaks(:,2);
    
    
    rhos = zeros(nLines,1);
    thetas = zeros(nLines,1);
    
    nms_H = nonMaximalSuppression(H);
    
    % return the first n maxima
    for i = 1: nLines
        [x, y] = find(nms_H == max(max(nms_H)),1);
        rhos(i) = x;
        thetas(i) = y;
        nms_H(x, y) = -Inf;
    end
    

    

end
        