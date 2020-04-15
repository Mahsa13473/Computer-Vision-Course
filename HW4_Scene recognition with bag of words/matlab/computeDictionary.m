clear;
close;
clc;

% Q1.3 Compute Dictionary of Visual Words
alpha = 75;
K = 100;

load('../data/traintest.mat','train_imagenames');

dictionary = getDictionary(train_imagenames, alpha, K, 'harris');
filterBank = createFilterBank();
save('dictionaryHarris.mat', 'dictionary', 'filterBank');

dictionary = getDictionary(train_imagenames, alpha, K, 'random');
filterBank = createFilterBank();
save('dictionaryRandom.mat', 'dictionary', 'filterBank');