function [wordMap] = getVisualWords(I, filterBank, dictionary)
    I = double(I);
    % Handling gray scale images
    if (ndims(I) == 2)
        I = cat(3, I, I, I);
    end

    wordMap = zeros([size(I,1), size(I,2)], 'int16');
    filterResponse = extractFilterResponses(I, filterBank);
    for i = 1:size(I,1)
        a = filterResponse(i, :, :);
        dist = pdist2(squeeze(a), dictionary, 'cosine'); % euclidean
        [~, indices] = min(dist, [], 2);
        wordMap(i, :) = indices';
    end
end
