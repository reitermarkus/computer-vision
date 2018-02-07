function [features] = hog_features(img)
  hog = cv.HOGDescriptor();
  descriptors = hog.compute(img);

  features = transpose(cv.kmeans(descriptors, rows(descriptors)));
end
