% Part 2: Build Visual Scene Recognition System

clear;
close;
clc;


%% Q2.1 Convert image to word map
% class 1: campus

I1 = imread('../data/campus/sun_abslhphpiejdjmpz.jpg');
I2 = imread('../data/campus/sun_acmiuobndrlyknxn.jpg');
I3 = imread('../data/campus/sun_bcgsqwhgjskwjkpr.jpg');

filterBank = createFilterBank();

figure
subplot 331
imshow(I1)
title('Original')

load('dictionaryHarris.mat');
[wordMap] = getVisualWords(I1, filterBank, dictionary);

subplot 332
imshow(label2rgb(wordMap))
title('Harris')

load('dictionaryRandom.mat');
[wordMap] = getVisualWords(I1, filterBank, dictionary);
subplot 333
imshow(label2rgb(wordMap))
title('Random')

subplot 334
imshow(I2)
title('Original')

load('dictionaryHarris.mat');
[wordMap] = getVisualWords(I2, filterBank, dictionary);
subplot 335
imshow(label2rgb(wordMap))
title('Harris')

load('dictionaryRandom.mat');
[wordMap] = getVisualWords(I2, filterBank, dictionary);
subplot 336
imshow(label2rgb(wordMap))
title('Random')

subplot 337
imshow(I3)
title('Original')

load('dictionaryHarris.mat');
[wordMap] = getVisualWords(I3, filterBank, dictionary);
subplot 338
imshow(label2rgb(wordMap))
title('Harris')

load('dictionaryRandom.mat');
[wordMap] = getVisualWords(I3, filterBank, dictionary);
subplot 339
imshow(label2rgb(wordMap))
title('Random')

%% Q2.1 Convert image to word map
% class 2: bedroom

I1 = imread('../data/bedroom/sun_aojckxubwndogqrh.jpg');
I2 = imread('../data/bedroom/sun_aqjgwbfbsrthnzub.jpg');
I3 = imread('../data/bedroom/sun_amewqmzsjzykyove.jpg');

figure
subplot 331
imshow(I1)
title('Original')

load('dictionaryHarris.mat');
[wordMap] = getVisualWords(I1, filterBank, dictionary);
subplot 332
imshow(label2rgb(wordMap))
title('Harris')

load('dictionaryRandom.mat');
[wordMap] = getVisualWords(I1, filterBank, dictionary);
subplot 333
imshow(label2rgb(wordMap))
title('Random')

subplot 334
imshow(I2)
title('Original')

load('dictionaryHarris.mat');
[wordMap] = getVisualWords(I2, filterBank, dictionary);
subplot 335
imshow(label2rgb(wordMap))
title('Harris')

load('dictionaryRandom.mat');
[wordMap] = getVisualWords(I2, filterBank, dictionary);
subplot 336
imshow(label2rgb(wordMap))
title('Random')

subplot 337
imshow(I3)
title('Original')

load('dictionaryHarris.mat');
[wordMap] = getVisualWords(I3, filterBank, dictionary);
subplot 338
imshow(label2rgb(wordMap))
title('Harris')

load('dictionaryRandom.mat');
[wordMap] = getVisualWords(I3, filterBank, dictionary);
subplot 339
imshow(label2rgb(wordMap))
title('Random')
