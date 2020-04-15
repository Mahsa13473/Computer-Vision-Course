function [ h ] = getImageFeatures(wordMap, dictionarySize)
    [r, c] = size(wordMap);
    [h, ~] = histcounts(wordMap(:), dictionarySize);
    h = double(h)/(r*c);
end

