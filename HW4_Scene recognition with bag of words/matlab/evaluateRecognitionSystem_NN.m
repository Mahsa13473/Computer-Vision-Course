clear;
close;
clc;

traintest = load('../data/traintest.mat');
testImages = traintest.test_imagenames;
targetLabels = traintest.test_labels;
yLabels = zeros(size(targetLabels));
mapping = traintest.mapping;

%% Random
classifier = load('../matlab/visionRandom.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');
dict = classifier.dictionary;
dictSize = size(dict, 1);
filterBank = classifier.filterBank;
trainFeatures = classifier.trainFeatures;
trainLabels = classifier.trainLabels;
nClasses = size(mapping, 2);

for i=1:numel(testImages)
    fileName =  cell2mat(testImages(i));
    I = imread(strcat('../data/', fileName));
    wordMap = getVisualWords(I, filterBank, dict);
    testFeatures = getImageFeatures(wordMap, dictSize);
    dist = getImageDistance(testFeatures, trainFeatures, 'chi2');
    [~, index] = min(dist);
    yLabels(:, i) = trainLabels(index);
end

confusionM = zeros([nClasses, nClasses], 'int16');
for i=1:size(yLabels, 2)
    confusionM(targetLabels(:, i), yLabels(:, i)) = confusionM(targetLabels(:, i), yLabels(:, i)) + 1; 
end

nCorrect = sum(diag(confusionM));
acc = nCorrect/size(targetLabels, 2);

disp('Sampling = Random');
disp('Distance metric = Chi2');
ACC = ['Accuracy = ', num2str(acc)];
disp(ACC);
disp('Confusion Matrix = ');
disp(confusionM)

for i=1:numel(testImages)
    fileName =  cell2mat(testImages(i));
    I = imread(strcat('../data/', fileName));
    wordMap = getVisualWords(I, filterBank, dict);
    testFeatures = getImageFeatures(wordMap, dictSize);
    dist = getImageDistance(testFeatures, trainFeatures, 'euclidean');
    [~, index] = min(dist);
    yLabels(:, i) = trainLabels(index);
end

confusionM = zeros([nClasses, nClasses], 'int16');
for i=1:size(yLabels, 2)
    confusionM(targetLabels(:, i), yLabels(:, i)) = confusionM(targetLabels(:, i), yLabels(:, i)) + 1; 
end

nCorrect = sum(diag(confusionM));
acc = nCorrect/size(targetLabels, 2);

disp('Sampling = Random');
disp('Distance metric = Euclidean');
ACC = ['Accuracy = ', num2str(acc)];
disp(ACC);
disp('Confusion Matrix = ');
disp(confusionM);

%% Harris
classifier = load('../matlab/visionHarris.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');
dict = classifier.dictionary;
dictSize = size(dict, 1);
filterBank = classifier.filterBank;
trainFeatures = classifier.trainFeatures;
trainLabels = classifier.trainLabels;
nClasses = size(mapping, 2);

for i=1:numel(testImages)
    fileName =  cell2mat(testImages(i));
    I = imread(strcat('../data/', fileName));
    wordMap = getVisualWords(I, filterBank, dict);
    testFeatures = getImageFeatures(wordMap, dictSize);
    dist = getImageDistance(testFeatures, trainFeatures, 'chi2');
    [~, index] = min(dist);
    yLabels(:, i) = trainLabels(index);
end

confusionM = zeros([nClasses, nClasses], 'int16');
for i=1:size(yLabels, 2)
    confusionM(targetLabels(:, i), yLabels(:, i)) = confusionM(targetLabels(:, i), yLabels(:, i)) + 1; 
end

nCorrect = sum(diag(confusionM));
acc = nCorrect/size(targetLabels, 2);

disp('Sampling = Harris');
disp('Distance metric = Chi2');
ACC = ['Accuracy = ', num2str(acc)];
disp(ACC);
disp('Confusion Matrix = ');
disp(confusionM)

for i=1:numel(testImages)
    fileName =  cell2mat(testImages(i));
    I = imread(strcat('../data/', fileName));
    wordMap = getVisualWords(I, filterBank, dict);
    testFeatures = getImageFeatures(wordMap, dictSize);
    dist = getImageDistance(testFeatures, trainFeatures, 'euclidean');
    [~, index] = min(dist);
    yLabels(:, i) = trainLabels(index);
end

confusionM = zeros([nClasses, nClasses], 'int16');
for i=1:size(yLabels, 2)
    confusionM(targetLabels(:, i), yLabels(:, i)) = confusionM(targetLabels(:, i), yLabels(:, i)) + 1; 
end

nCorrect = sum(diag(confusionM));
acc = nCorrect/size(targetLabels, 2);

disp('Sampling = Harris');
disp('Distance metric = Euclidean');
ACC = ['Accuracy = ', num2str(acc)];
disp(ACC);
disp('Confusion Matrix = ');
disp(confusionM)
