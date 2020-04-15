% Part 1: Build Visual Words Dictionary

clear;
close;
clc;

%% Q1.1 Extract Filter Responses
I = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
figure;
subplot 141
imshow(I)
title('image')

I = double(I);
filterResponses = extractFilterResponses(I, createFilterBank());
n = 20;
% rand_ind = randi(3*n, 1, 3);
rand_ind = [3, 12, 17];

subplot 142
imshow(filterResponses(:,:,rand_ind(1)), [])
title(['filter ' num2str(rand_ind(1))])

subplot 143
imshow(filterResponses(:,:,rand_ind(2)), [])
title(['filter ' num2str(rand_ind(2))])

subplot 144
imshow(filterResponses(:,:,rand_ind(3)), [])
title(['filter ' num2str(rand_ind(3))])


%%  Q1.2 Collect sample of points from image
alpha = 500; % number of points
k = 0.05;

I = imread('../data/campus/sun_abslhphpiejdjmpz.jpg');

figure;
subplot 121
[points_Random] = getRandomPoints(I, alpha);
imshow(I,[]);
hold on
plot(points_Random(:,2), points_Random(:,1), '.b');
title([num2str(alpha) ' Random points'])

subplot 122
[points_Harris] = getHarrisPoints(I, alpha, k);
imshow(I,[]);
hold on
plot(points_Harris(:,2), points_Harris(:,1), '.r');
title([num2str(alpha) ' Harris points'])

Show the results of your corner detector on 3 different images
alpha = 150; % number of points
k = 0.05;

I1 = imread('../data/airport/sun_aftwiluyleufatic.jpg');
I2 = imread('../data/bedroom/sun_ajeggrwycdaliwsv.jpg');
I3 = imread('../data/landscape/sun_bcgadxvhfctdiekf.jpg');

figure
subplot 131
[points_Harris] = getHarrisPoints(I1, alpha, k);
imshow(I1,[]);
hold on
plot(points_Harris(:,2), points_Harris(:,1), '.r');

subplot 132
[points_Harris] = getHarrisPoints(I2, alpha, k);
imshow(I2,[]);
hold on
plot(points_Harris(:,2), points_Harris(:,1), '.b');

subplot 133
[points_Harris] = getHarrisPoints(I3, alpha, k);
imshow(I3,[]);
hold on
plot(points_Harris(:,2), points_Harris(:,1), '.r');

%% Q1.3 Compute Dictionary of Visual Words
alpha = 75;
K = 100;

load('../data/traintest.mat','train_imagenames');

dictionary = getDictionary(train_imagenames, alpha, K, 'harris');
filterBank = createFilterBank();
save('dictionaryHarris.mat', 'dictionary', 'filterBank');

dictionary = getDictionary(train_imagenames, alpha, K, 'random');
filterBank = createFilterBank();
save('dictionaryRandom.mat', 'dictionary', 'filterBank');
