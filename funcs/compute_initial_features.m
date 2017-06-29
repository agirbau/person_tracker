%% Function to compute the features for the person tracker.

function features_vector = compute_initial_features(img,mask)

[features,features_vector] = create_model_3d(img,mask);