clear;
close;
clc;

traintest = load('../data/traintest.mat');
trainImages = traintest.train_imagenames;
trainLabels = traintest.train_labels';

%% Random
dict = load('../matlab/dictionaryRandom.mat');
dictionary = dict.dictionary;
filterBank = dict.filterBank;

dictionarySize = size(dictionary, 1);
trainFeatures = zeros(size(trainImages, 1), dictionarySize);

for i=1:numel(trainImages)
    fileName =  cell2mat(trainImages(i));
    wordMap = load(strcat('../data/', fileName(1:end-4), '_r.mat'));
    trainFeatures(i, :) = getImageFeatures(wordMap.wordMap, dictionarySize);
end

save('../matlab/visionRandom.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');

%% Harris
dict = load('../matlab/dictionaryHarris.mat');
dictionary = dict.dictionary;
filterBank = dict.filterBank;

dictionarySize = size(dictionary, 1);
trainFeatures = zeros(size(trainImages, 1), dictionarySize);

for i=1:numel(trainImages)
    fileName =  cell2mat(trainImages(i));
    wordMap = load(strcat('../data/', fileName(1:end-4), '_h.mat'));
    trainFeatures(i, :) = getImageFeatures(wordMap.wordMap, dictionarySize);
end

save('../matlab/visionHarris.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');
