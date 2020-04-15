clear;
close all;

traintest = load('../data/traintest.mat');
trainImages = traintest.train_imagenames;
trainLabels = traintest.train_labels;

dict = load('../matlab/dictionaryHarris.mat');
dictionary = dict.dictionary;
filterBank = dict.filterBank;

dictionarySize = size(dictionary, 1);
trainFeatures = zeros(size(trainImages, 1), dictionarySize);

for i=1:numel(trainImages)
    fileName =  cell2mat(trainImages(i));
    wordMap = load(strcat('../data/', fileName(1:end-4)));
    trainFeatures(i, :) = getImageFeatures(wordMap.wordMap, dictionarySize);
end

save('../ec/visionSVM.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');