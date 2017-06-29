%% Function to prepare the temporal folder for person_search tracker

function query = prepare_personsearch(query)

query.tmp_personsearch = fullfile(main_root,'tmp_personsearch');

delete(fullfile(query.tmp_personsearch,'*'));
[~] = rmdir(query.tmp_personsearch);

mkdir(query.tmp_personsearch);

%imwrite(query.frame,fullfile(query.tmp_personsearch,query.frame_name));
    
