function [dist] = getImageDistance(hist1, histSet, method)

    if strcmpi(method, 'euclidean')
        dist = sqrt(sum((histSet - hist1).^2, 2));
    end 
    if strcmpi(method, 'chi2')
        a = (hist1 - histSet).^2;
        b = hist1 + histSet;
        a(b==0) = 0;
        b(b==0) = 1;
        dist = 0.5 * sum(a./b, 2);    
    end

end

