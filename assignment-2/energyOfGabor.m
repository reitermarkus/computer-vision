function energy = energyOfGabor(video, gabor_size, sigma, theta)
  [g_even, g_odd] = gaborFilter(gabor_size, sigma, sigma, theta, 2, 0, 0);

  frames = [];

  video = permute(video, [1, 3, 2]);

  for row = 1 : size(video, 3)
    image = squeeze(video(:, :, row));

    image_even = conv2(double(image), g_even, 'same');
    image_odd = conv2(double(image), g_odd, 'same');

    frame = sqrt(image_even.^2 + image_odd.^2);

    frames = cat(3, frames, frame);
  end

  energy = permute(frames, [1, 3, 2]);
end
