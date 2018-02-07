function [output_images] = sample_images(input_images, count)
  indices = randperm(length(input_images))(1:count);

  output_images = input_images(:, indices);
end
