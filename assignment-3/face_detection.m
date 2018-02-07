pkg load image

addpath('./imHistogram')
addpath('./libsvm/matlab')

faces = read_images('./253.faces-easy-101');
clutter = read_images('./257.clutter');

sample_faces = sample_images(faces, 225);
sample_clutter = sample_images(clutter, 225);

labels = [];
features = [];

for i = 1:length(sample_faces)
  labels = [labels; 1]; # contains face
  features = [features; gabor_features(sample_faces{i})];
end

for i = 1:length(sample_clutter)
  labels = [labels; 0]; # does not contain face
  features = [features; gabor_features(sample_clutter{i})];
end

model = svmtrain(double(labels), double(features), [])
