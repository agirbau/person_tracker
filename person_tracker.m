%% Person tracker
% pass a set of queries (images) and return a set of predictions for every
% image. If the objective is not found, skip the frame.

function [pred,vid] = person_tracker(track_dir,mask_dir,model_frame,model_mask,person_model,gpu_id)

% Will consume about 8.5 GB of GPU MEM (MNC)
if nargin == 5
    gpu_id = 0;
end


% 1.prepare the frames structure
seq_frames = dir(fullfile(track_dir,'*.*'));
seq_frames = seq_frames(~ismember({seq_frames.name},{'.','..'}));  
frames_name = {seq_frames.name};


% 2.person detector for a set of frames
obj_proposal(query.track_dir,query.tmp_personsearch,frames_name,gpu_id);


% 3.model comparison for every frame with original model (Battacharyya or chi2)
b_th = 0.07; % 0.07
ii = 1;
for i = 1:length(frames_name)

    if i ~= relative_frame

        frame_tmp = imread(fullfile(query.track_dir,frames_name{i}));

        % TODO: load mask of multiple annotations. RBG2label. Compare models.
        % Choose 1 mask.

        [~,mask_name] = fileparts(frames_name{i});
        mask_name = [mask_name '_mask.png'];

        mask_multiple = imread(fullfile(query.tmp_personsearch,mask_name));
        [mask_label,labels] = rgb2label(mask_multiple);

    %     subplot(3,3,i);
    %     imshow(mask_label,[]);

        % label=1 is background
        b_dist = ones(1,length(labels));

        for j = 2:length(labels)
            mask_tmp = mask_label == labels(j);
            b_dist(j) = bhatt_distance(frame_tmp,mask_tmp,person_model); 
        end

        [b_min,idx] = min(b_dist);

        if b_min <= b_th;
            pred(:,:,ii) = double(mask_label == labels(idx));
            vid{ii} = frame_tmp;  
            ii = ii +1;
        end
    else
        pred(:,:,ii) = query.mask;
        vid{ii} = query.frame;  
        ii = ii +1;
    end

end

