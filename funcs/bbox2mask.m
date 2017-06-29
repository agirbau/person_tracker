%% Function to take a bbox [xmin,ymin,xmax,ymax] and return a mask based on the size of an speficied image

function mask = bbox2mask(img,bbox)

bbox = round(bbox);
bbox = max(1,bbox);
mask = zeros(size(img(:,:,1)));
mask(bbox(2):bbox(4),bbox(1):bbox(3),:) = 1; % In matlab X and Y are flipped [xmin ymin xmax ymax]