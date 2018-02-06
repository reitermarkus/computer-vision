function [output_image] = normalize_image(input_image)
  output_image = uint8((double(input_image) - double(min(min(input_image)))) * (255 / double(max(max(input_image)) - min(min(input_image)))));
end
