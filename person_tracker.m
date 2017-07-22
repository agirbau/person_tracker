%% Person tracker using MNC
% pass a set of queries (images) and return a set of predictions for every
% image. If the objective is not found, skip the frame.

% Inputs: (folder_with_frames_to_track,vector_person_model,gpu_id,optional_dir_for_MNC)
% Ouputs: (masks,frames)

function [pred,vid] = person_tracker(track_dir,person_model,gpu_id,mask_dir)

% Will consume about 8.5 GB of GPU MEM (MNC)
if nargin < 4
    mask_dir = fullfile(person_tracker_root,'tmp_mask');
    if nargin < 3
        gpu_id = 0;
    end
end


% 1.prepare the frames structure
seq_frames = dir(fullfile(track_dir,'*.*'));
seq_frames = seq_frames(~ismember({seq_frames.name},{'.','..'}));  
frames_name = {seq_frames.name};
frames_name = sort_nat(frames_name);


% 2.person detector for a set of frames
obj_proposal(track_dir,mask_dir,frames_name,gpu_id);


% 3.model comparison for every frame with original model (Battacharyya or chi2)
frame_tmp = imread(fullfile(track_dir,frames_name{1}));
vid = cell(1,length(frames_name));
pred = zeros(size(frame_tmp,1),size(frame_tmp,2),length(frames_name));

b_th = 0.07; % 0.07

for i = 1:length(frames_name)

    % Load frame
    frame_tmp = imread(fullfile(track_dir,frames_name{i}));

    [~,mask_name] = fileparts(frames_name{i});
    mask_name = [mask_name '_mask.png'];

    mask_multiple = imread(fullfile(mask_dir,mask_name));
    [mask_label,labels] = rgb2label(mask_multiple);

    b_dist = ones(1,length(labels));

    % For each person extracted compute similarity
    for j = 2:length(labels)
        mask_tmp = mask_label == labels(j);
        [~,tmp_model] = extract_color_features(frame_tmp,mask_tmp);
        b_dist(j) = compute_distance(person_model,tmp_model,'bhatt');
    end

    [b_min,idx] = min(b_dist);

    % If the most similar is lower than b_th assume that the person is the same
    % as the model
    if b_min <= b_th;
        pred(:,:,i) = double(mask_label == labels(idx));
    end

    vid{i} = frame_tmp;

end

