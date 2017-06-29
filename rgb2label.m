%% Function to convert a 3 channel matrix (RGB) to a labeled one.
% This is useful to generate a labeled gray level matrix for multiple
% annotations in a video.

function [labeled_img,labels] = rgb2label(img)

img_rgb_labels  = double(img(:,:,1)) + double(img(:,:,2))*300 + double(img(:,:,3))*600;
labels_rgb      = unique(img_rgb_labels);

labeled_img = zeros(size(img,1),size(img,2));
labels = zeros(size(labels_rgb));

% Set background (0) to label 1
labeled_img(img_rgb_labels == 0) = 1;

for i = 1:length(labels_rgb)
    if(labels_rgb(i) ~= 0)
        labeled_img(img_rgb_labels == labels_rgb(i)) = i;
        labels(i) = i;
    else
        labels(i) = 1;
    end
end