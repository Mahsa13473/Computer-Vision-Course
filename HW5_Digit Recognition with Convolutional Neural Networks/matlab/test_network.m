clc;
clear;

layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

preds = [];
%% Testing the network
for i=1:100:size(xtest, 2)
    [~, pred] = convnet_forward(params, layers, xtest(:, i:i+99));
    A = reshape(xtest(:,i), 28, 28);
    preds = [preds,pred];
end

[~, idx] = max(preds);
predicted_class = idx;

C = confusionmat(ytest, predicted_class)

figure;
confusionchart(C);

