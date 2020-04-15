
addpath('../ec/matlab');

dataset = load('../data/traintest.mat');
cell_size = [2 2];
prepath = '../data/';

T = length(dataset.train_imagenames);
t = length(dataset.test_imagenames);

precision = 15; 
n = 360/precision;
N = 3*n;                             

%% Generate HOG features on trainset
trainFeatures = zeros(T, N);
for i = 1:T
    I = imread(strcat(prepath, dataset.train_imagenames{i}));
    trainFeatures(i, :) = extractHOGResponse(I, precision);
end
save('../ec/visionHOG.mat', 'trainFeatures')

%% Train SVM
svm = svmtrain(dataset.train_labels', trainFeatures, '-t 0 -c 5000 -q');

%% Generate HOG features for test set
testFeatures = zeros(t, N);
for i = 1:t
    I = imread(strcat(prepath, dataset.test_imagenames{i}));
    testFeatures(i, :) = extractHOGResponse(I, precision);
end

%% Predict SVM

[pLabelsLinear, aLinear, ~] = svmpredict(dataset.test_labels', testFeatures, svm);
