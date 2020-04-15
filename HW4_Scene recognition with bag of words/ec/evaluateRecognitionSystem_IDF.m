clear;
close;
clc;

traintest = load('../data/traintest.mat');
testImages = traintest.test_imagenames;
mapping = traintest.mapping;
trueLabels = traintest.test_labels;
c =10000;

data = load('../ec/visionSVM.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');
IDF = load('../ec/idf.mat', 'IDF');
idf = (IDF.IDF).*c;
filterBank = data.filterBank;
dict = data.dictionary;
dictSize = size(dict, 1);
trainFeatures = data.trainFeatures;
trainFeatures = trainFeatures.*idf;
trainLabels = data.trainLabels;
nClasses = size(mapping, 2);

disp('using SVM and polynomial kernel');
t = templateSVM('Standardize', 1, 'KernelFunction','polynomial', 'KernelScale', 'auto');
classifier = fitcecoc(trainFeatures, trainLabels, 'Learners', t, 'Coding', 'onevsall');

predLabels = zeros([1, size(trueLabels, 2)]);

for i=1:numel(testImages)
    fileName =  cell2mat(testImages(i));
    I = imread(strcat('../data/', fileName));
    wordMap = getVisualWords(I, filterBank, dict);
    testFeatures = getImageFeatures(wordMap, dictSize);
    testFeatures = testFeatures.*idf;
    predLabels(:, i) = predict(classifier, testFeatures);
end

confusionM = zeros([nClasses, nClasses], 'int16');
for i=1:size(predLabels, 2)
    confusionM(trueLabels(:, i), predLabels(:, i)) = confusionM(trueLabels(:, i), predLabels(:, i)) + 1; 
end

n_Correct = sum(diag(confusionM));
acc = n_Correct/size(trueLabels, 2);

Acc = ['Accuracy = ', num2str(acc)];
disp(Acc);
disp('Confusion Matrix = ')
disp(confusionM);
