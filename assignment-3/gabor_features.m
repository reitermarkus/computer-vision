function [features] = gabor_features(img)
  filtered_image = double(img) * 0;

  # Loop through theta 0° – 360°, in steps of 10°.
  for i = 0:35
    theta = i * 10 * pi / 180;

    energy = energy_of_gabor(img, 15, 10, 10, theta, 2, 0, 0);

    filtered_image = imadd(filtered_image, double(energy));
  end

  filtered_image = normalize_image(filtered_image);

  histogram = imHistogram(filtered_image, 150);

  features = double(histogram);
end
