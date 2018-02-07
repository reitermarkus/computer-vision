pkg load image

addpath('./imHistogram')
addpath('./libsvm/matlab')

disp('Reading images …');
faces = read_images('./253.faces-easy-101');
clutter = read_images('./257.clutter');
disp('Done.');

disp('Picking training samples …');
training_faces = sample_images(faces, 225);
training_clutter = sample_images(clutter, 225);
disp('Done.');

labels = [];
features = [];

disp('Generating training face features …');
for i = 1:length(training_faces)
  labels = [labels; 1]; # contains face
  features = [features; gabor_features(training_faces{i})];
end
disp('Done.');

disp('Generating training clutter features …');
for i = 1:length(training_clutter)
  labels = [labels; 0]; # does not contain face
  features = [features; gabor_features(training_clutter{i})];
end
disp('Done.');

disp('Training SVM …');
model = svmtrain(double(labels), double(features));
disp('Done.');

disp('Picking test samples …');
test_faces = sample_images(faces, 225);
test_clutter = sample_images(clutter, 225);
disp('Done.');

labels = [];
features = [];

disp('Generating test face features …');
for i = 1:length(test_faces)
  labels = [labels; 1];
  features = [features; gabor_features(test_faces{i})];
end
disp('Done.');

disp('Generating test clutter features …');
for i = 1:length(test_clutter)
  labels = [labels; 0];
  features = [features; gabor_features(test_clutter{i})];
end
disp('Done.');

disp('SVM is predicting labels …');
predicted_labels = svmpredict(double(labels), double(features), model);
