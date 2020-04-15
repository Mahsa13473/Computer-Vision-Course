function [dictionary] = getDictionary(imgPaths, alpha, K, method)
    
    filterBank = createFilterBank();
    features = zeros([alpha*length(imgPaths), size(filterBank, 1)*3], 'double');
    
    for i=1:numel(imgPaths)
        I = imread(strcat('../data/', cell2mat(imgPaths(i))));
        I = double(I);
        % to handle gray scale images
        if (ndims(I) == 2)
            I = cat(3, I, I, I);
        end
        
        filterResponses = extractFilterResponses(I, filterBank);
        if strcmpi(method, 'random')
            pts = getRandomPoints(I, alpha);
        else
            k = 0.05;
            pts = getHarrisPoints(I, alpha, k);
        end
        for p=1:size(pts,1)
            feature = filterResponses(pts(p, 1), pts(p, 2), :);
            features(((i-1)*size(pts, 1) + p), :) = feature(:)';
        end       
    end
    [~, dictionary] = kmeans(features, K, 'EmptyAction', 'drop');
    % [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop', 'MaxIter',400);
end
 