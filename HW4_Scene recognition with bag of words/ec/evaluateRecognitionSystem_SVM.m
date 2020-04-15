clear;
close;
clc;

traintest = load('../data/traintest.mat');
testImages = traintest.test_imagenames;
mapping = traintest.mapping;
trueLabels = traintest.test_labels;

data = load('../ec/visionSVM.mat', 'dictionary', 'filterBank','trainFeatures', 'trainLabels');
filterBank = data.filterBank;
dict = data.dictionary;
dictSize = size(dict, 1);
trainFeatures = data.trainFeatures;
trainLabels = data.trainLabels;
nClasses = size(mapping, 2);

disp('Training SVM 1 with gaussian kernel');
t = templateSVM('Standardize', 1, 'KernelFunction','gaussian', 'KernelScale', 'auto');
classifier1 = fitcecoc(trainFeatures, trainLabels, 'Learners', t, 'Coding', 'onevsall');

disp('Training SVM 2 with polynomial kernel')
t = templateSVM('Standardize', 1, 'KernelFunction','polynomial', 'KernelScale', 'auto');
classifier2 = fitcecoc(trainFeatures, trainLabels, 'Learners', t, 'Coding', 'onevsall');

disp('Training SVM 3 with linear kernel')
t = templateSVM('Standardize', 1, 'KernelFunction','linear', 'KernelScale', 'auto');
classifier3 = fitcecoc(trainFeatures, trainLabels, 'Learners', t, 'Coding', 'onevsall');

disp('Training SVM 4 with rbf kernel')
t = templateSVM('Standardize', 1, 'KernelFunction','rbf', 'KernelScale', 'auto');
classifier4 = fitcecoc(trainFeatures, trainLabels, 'Learners', t, 'Coding', 'onevsall');

pred_Labels1 = zeros([1, size(trueLabels, 2)]);
pred_Labels2 = zeros([1, size(trueLabels, 2)]);
pred_Labels3 = zeros([1, size(trueLabels, 2)]);
pred_Labels4 = zeros([1, size(trueLabels, 2)]);

disp('Running test');
for i=1:numel(testImages)
    fileName =  cell2mat(testImages(i));
    I = imread(strcat('../data/', fileName));
    wordMap = getVisualWords(I, filterBank, dict);
    testFeatures = getImageFeatures(wordMap, dictSize);
    
    pred_Labels1(:, i) = predict(classifier1, testFeatures);
    pred_Labels2(:, i) = predict(classifier2, testFeatures);
    pred_Labels3(:, i) = predict(classifier3, testFeatures);
    pred_Labels4(:, i) = predict(classifier4, testFeatures);
end

confusionM1 = zeros([nClasses, nClasses], 'int16');
for i=1:size(pred_Labels1, 2)
    confusionM1(trueLabels(:, i), pred_Labels1(:, i)) = confusionM1(trueLabels(:, i), pred_Labels1(:, i)) + 1; 
end

confusionM2 = zeros([nClasses, nClasses], 'int16');
for i=1:size(pred_Labels2, 2)
    confusionM2(trueLabels(:, i), pred_Labels2(:, i)) = confusionM2(trueLabels(:, i), pred_Labels2(:, i)) + 1; 
end

confusionM3 = zeros([nClasses, nClasses], 'int16');
for i=1:size(pred_Labels3, 2)
    confusionM3(trueLabels(:, i), pred_Labels3(:, i)) = confusionM3(trueLabels(:, i), pred_Labels3(:, i)) + 1; 
end

confusionM4 = zeros([nClasses, nClasses], 'int16');
for i=1:size(pred_Labels4, 2)
    confusionM4(trueLabels(:, i), pred_Labels4(:, i)) = confusionM4(trueLabels(:, i), pred_Labels4(:, i)) + 1; 
end

n_Correct = sum(diag(confusionM1));
acc = n_Correct/size(trueLabels, 2);

acc_svm1 = ['Accuracy for SVM1 = ', num2str(acc)];
disp(acc_svm1);
disp('Confusion Matrix for SVM1 = ')
disp(confusionM1);


n_Correct = sum(diag(confusionM2));
acc = n_Correct/size(trueLabels, 2);

acc_svm2 = ['Accuracy for SVM2 = ', num2str(acc)];
disp(acc_svm2);
disp('Confusion Matrix for SVM2 = ')
disp(confusionM2);

n_Correct = sum(diag(confusionM3));
acc = n_Correct/size(trueLabels, 2);

acc_svm3 = ['Accuracy for SVM3 = ', num2str(acc)];
disp(acc_svm3);
disp('Confusion Matrix for SVM3 = ')
disp(confusionM3);

n_Correct = sum(diag(confusionM4));
acc = n_Correct/size(trueLabels, 2);

acc_svm4 = ['Accuracy for SVM4 = ', num2str(acc)];
disp(acc_svm4);
disp('Confusion Matrix for SVM4 = ')
disp(confusionM4);
