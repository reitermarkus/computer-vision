function [energy] = energy_of_gabor(img, n, sigma_y, sigma_x, theta, pr, x0, y0)
  [g1 g2] = gabor_filter(n, sigma_y, sigma_x, theta, pr, x0, y0);

  conv_img1 = conv2(double(img), g1, 'same');
  conv_img2 = conv2(double(img), g2, 'same');

  energy = sqrt(conv_img1.**2 + conv_img2.**2);
end
