function [images] = read_images(directory)
  paths = glob([directory '/*.jpg']);

  images = cell();

  for i = 1:length(paths)
    img = imread(cell2mat(paths(i)));

    if ndims(img) >= 3
      img = rgb2gray(img);
    end

    img = imresize(img, [160, 240]);

    images(i) = normalize_image(img);
  end
end
