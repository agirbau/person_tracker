%% Wrapper for modified object proposal function in python (MNC)
% 
% example: obj_proposal('./data/demo','./data/demo',['2008_000910.jpg 2008_001602.jpg']);
%
% Be aware of the relative pathing to the images location.
% 
% This is not prepared for individual frames (data directly) because the 
% initialization would start every time the function is called. Whenever it
% is possible, try to gather the data into the proposed form.

function obj_proposal(im_path,save_path,im_names,gpu_id)

if iscell(im_names)
    im_names_vec = ''; 
    for i = 1:length(im_names)
        im_names_vec = [im_names_vec ' ' im_names{i}];
    end
    im_names = im_names_vec;
end

cd(mnc_root)
% cd('/net/per920a/export/das14a/satoh-lab/hinami/work/MNC')

system(['./tools/object_proposal.py' ' --folder_path ' im_path ' --save_path ' save_path ' --im_names ' im_names ' --gpu ' num2str(gpu_id)]);

cd(person_tracker_root)