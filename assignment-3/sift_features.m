function [features] = sift_features(img)
  orb = cv.ORB();
  [keypoints descriptors] = orb.detectAndCompute(img);

  count = 150;

  if rows(descriptors) == 0
    features = zeros(1, count);
  else
    features = hist(transpose(cv.kmeans(descriptors, rows(descriptors))), count);
  end
end
