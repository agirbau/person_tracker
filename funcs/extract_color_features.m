function [hist3d,vect_hist3d] = extract_color_features(frame,mask)

% Number of bins for RGB information.
bins_rgb = 11; 

channel_r = double(frame(:,:,1));
channel_g = double(frame(:,:,2));
channel_b = double(frame(:,:,3));

% 3D histogram
hist3d = zeros(bins_rgb,bins_rgb,bins_rgb);

% TODO: do we need 2 fors? Implement this in C
val = find(mask); 
rr = ceil(max((channel_r(val)/255) * bins_rgb,1));
gg = ceil(max((channel_g(val)/255) * bins_rgb,1));
bb = ceil(max((channel_b(val)/255) * bins_rgb,1));

for i = 1:length(val)      
    hist3d(rr(i),gg(i),bb(i)) = hist3d(rr(i),gg(i),bb(i)) + 1;    
end

% % TODO: do we need 3 fors?
% % Cube 3D histogram to vector.
vect_hist3d = zeros(1,bins_rgb^3);
z = 1;

for k = 1:bins_rgb
    for i = 1:bins_rgb
        for j = 1:bins_rgb
            vect_hist3d(z) = hist3d(i,j,k);
            z = z+1;           
        end
    end
end

% Normalize
vect_hist3d = vect_hist3d / sum(vect_hist3d);
hist3d = hist3d / sum(sum(sum(hist3d)));

end