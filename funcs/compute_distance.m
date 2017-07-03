%% Function to compute the distance between 2 deep features

function dist = compute_distance(feat1,feat2,dist_type)

if nargin == 2
   dist_type = 'eucl'; 
end

%TODO: cosine distance or others
norm1 = sum(abs(feat1));
norm2 = sum(abs(feat2));
feat1 = feat1 / norm1;
feat2 = feat2 / norm2;
        
switch dist_type
    case 'eucl'
        dist = sqrt(sum((feat1 - feat2).^2));
    case 'bhatt'
        coef = sum(sqrt(abs(feat1 .* feat2)));
        dist = -log(coef);
end
