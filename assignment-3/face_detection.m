pkg load image

addpath('./imHistogram')
addpath('./libsvm/matlab')

disp('Reading images …');
faces = read_images('./253.faces-easy-101');
clutter = read_images('./257.clutter');
disp('Done.');

face_indices = randperm(430);
clutter_indices = randperm(430);

disp('Picking samples …');
training_faces = faces(:, face_indices(1:215));
test_faces = faces(:, face_indices(216:430));
training_clutter = clutter(:, clutter_indices(1:215));
test_clutter = clutter(:, clutter_indices(216:430));
disp('Done.');

training_labels = [];
training_features = [];

disp('Generating training face features …');
for i = 1:length(training_faces)
  training_labels = [training_labels; 1]; # contains face
  training_features = [training_features; gabor_features(training_faces{i})];
end
disp('Done.');

disp('Generating training clutter features …');
for i = 1:length(training_clutter)
  training_labels = [training_labels; 0]; # does not contain face
  training_features = [training_features; gabor_features(training_clutter{i})];
end
disp('Done.');

disp('Training SVM …');
model = svmtrain(double(training_labels), double(training_features));
disp('Done.');

test_labels = [];
test_features = [];

disp('Generating test face features …');
for i = 1:length(test_faces)
  test_labels = [test_labels; 1];
  test_features = [test_features; gabor_features(test_faces{i})];
end
disp('Done.');

disp('Generating test clutter features …');
for i = 1:length(test_clutter)
  test_labels = [test_labels; 0];
  test_features = [test_features; gabor_features(test_clutter{i})];
end
disp('Done.');

disp('SVM is predicting labels …');
predicted_labels = svmpredict(double(test_labels), double(test_features), model);
