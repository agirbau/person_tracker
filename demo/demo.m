%% Demo for person tracker 
% Andreu Girbau (agirbau@alu.etsetb.upc.edu)

% TODO: DEMO with bounding box
%       Use a better demo (this is very static)

% Define directory with the frames
track_dir = fullfile(person_tracker_root,'demo','frames');

% Define directory for saving the masks (optional, if not settled the masks
% will be erased after the tracking).
mask_dir = fullfile(person_tracker_root,'demo','masks');

% Load initial frame and mask
img = imread(fullfile(person_tracker_root,'demo','stacey.png'));
mask = imread(fullfile(person_tracker_root,'demo','stacey_mask.png'));

% Compute the person model (color)
[~,person_model] = extract_color_features(img,mask);

% Set GPU ID (0 if unspecified)
gpuID = 5;

% Track the person
[pred,vid] = person_tracker(track_dir,person_model,gpuID,mask_dir);

% Vizualize/save the results
for ii=1:size(pred,3)
    ccc = vid{ii};
    ccc(:,:,2) = min(255, vid{ii}(:,:,2) + 50*uint8(pred(:,:,ii)>0.5));
    imshow(ccc);
    pause(0.4);
end