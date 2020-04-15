clear;
close;
clc;

k_max = 40;

traintest = load('../data/traintest.mat');
testImages = traintest.test_imagenames;
mapping = traintest.mapping;
targetLabels = traintest.test_labels;

classifier = load('../data/visionHarris.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');
dict = classifier.dictionary;
dictSize = size(dict, 1);
filterBank = classifier.filterBank;
trainFeatures = classifier.trainFeatures;
nClasses = size(mapping, 2);
trainLabels = classifier.trainLabels;

y_Labels = zeros([k_max, size(targetLabels, 2)]);
y_Score = zeros([1, size(targetLabels, 2)]);
accs = zeros([k_max, 1]);

for k=1:k_max
    disp('k=');
    disp(k);
    for i=1:numel(testImages)
        fileName =  cell2mat(testImages(i));
        I = imread(strcat('../data/', fileName));
        wordMap = getVisualWords(I, filterBank, dict);
        testFeatures = getImageFeatures(wordMap, dictSize);
        dist = getImageDistance(testFeatures, trainFeatures, 'chi2');
        [~, indices] = mink(dist, k);
        y = mode(trainLabels(indices));
        y_Labels(k, i) = y;
        y_Score(:, i) = ~(y_Labels(k, i) - targetLabels(:, i));
    end
    accs(k, :) = sum(y_Score, 2)./size(targetLabels, 2);
    disp('Accuracy=');
    disp(accs(k, :));
end

[~, Amax] = max(accs);

figure;
plot(1:k_max, accs);
grid;
title('Accuracy for different k for kNN classification')
xlabel('k')
ylabel('Accuracy')


confusionM = zeros([nClasses, nClasses], 'int16');
for i=1:size(y_Labels, 2)
    confusionM(targetLabels(:, i), y_Labels(Amax, i)) = confusionM(targetLabels(:, i), y_Labels(Amax, i)) + 1; 
end


BestK = ['Best k =', num2str(Amax)];
disp(BestK);
BestAcc = ['Accuracy =', num2str(accs(Amax))];
disp(BestAcc);
disp('Confusion Matrix = ');
disp(confusionM);

