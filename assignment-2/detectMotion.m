function motion = detectMotion(video, gabor_size, sigma, theta)
  video = permute(video, [1, 3, 2]);
  video = energyOfGabor(video, gabor_size, sigma, theta);
  motion = permute(video, [1, 3, 2]);
end
