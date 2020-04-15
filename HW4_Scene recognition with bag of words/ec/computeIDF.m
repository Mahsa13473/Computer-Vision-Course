clear;
close;
clc;

traintest = load('../data/traintest.mat');
trainImages = traintest.train_imagenames;
trainLabels = traintest.train_labels;

dict = load('../matlab/dictionaryHarris.mat');
dictionary = dict.dictionary;
dictSize = size(dictionary, 1);
T = size(trainImages, 2);
IDF = ones([1, dictSize], 'double');

for k=1:dictSize
    d = 0;
    for i=1:numel(trainImages)
        fileName =  cell2mat(trainImages(i));
        wordMap = load(strcat('../data/', fileName(1:end-4), '_h.mat'));
        if(sum(sum(ismember(wordMap.wordMap, k))) > 0)
            d = d + 1;
        end
    end
    disp(k);
    IDF(:, k) = log(double(T)/double(d));
end

save('../ec/idf.mat', 'IDF');