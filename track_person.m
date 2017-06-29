%% Simple person tracker

function [pred,vid] = track_person(query,relative_frame)

addpath(genpath(fullfile(RBPF_root,'particle_filter')));

% 1.Prepare folder structure
query = prepare_personsearch(query);


% 2.Compute query model
person_model = compute_initial_features(query.frame,query.mask);


% 3.Tracking (instance search of the person in multiple frames)
[pred,vid] = person_tracker(query,person_model,relative_frame);


delete(fullfile(query.tmp_personsearch,'*'));
[~] = rmdir(query.tmp_personsearch);

% cd(main_root)