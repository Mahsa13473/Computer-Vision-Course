function [points] = getRandomPoints(I, alpha)
% return random pixels locations inside the image
x_rand = randi(size(I,2), alpha, 1);
y_rand = randi(size(I,1), alpha, 1);
points = [y_rand x_rand];
end