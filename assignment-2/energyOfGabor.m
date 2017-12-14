function energy = energyOfGabor(video, gabor_size, sigma, theta)
  [g_even, g_odd] = gaborFilter(gabor_size, sigma, sigma, theta, 2, 0, 0);

  frames = [];

  for col = 1 : size(video, 2)
    column = squeeze(video(:, col, :));

    column_even = conv2(column, g_even);
    column_odd = conv2(column, g_odd);

    frame = sqrt(column_even.^2 + column_odd.^2);

    frames = cat(3, frames, frame);
  end

  energy = permute(frames, [1, 3, 2]);
end
