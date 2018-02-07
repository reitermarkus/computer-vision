function [features] = compute_features(img, algorithm)
  switch (algorithm)
    case 0
      features = gabor_features(img);
    case 1
      features = sift_features(img);
    case 2
      features = hog_features(img);
  end
end
