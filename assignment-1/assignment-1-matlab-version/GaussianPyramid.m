function [img] = GaussianPyramid(img,levels)
  g_filter = [1 4 6 4 1]/16;

  for i = 1 : levels
    % convolve image with filter
    img = conv2(g_filter,g_filter,img,'same');
    % calculate image size
    img_size = size(img);
    img = img(1:2:img_size(1),1:2:img_size(2));
  end
  
  