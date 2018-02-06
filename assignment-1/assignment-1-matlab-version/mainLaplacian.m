img = imread('You.jpg','JPG'); 

for i = 1 : 4
  % get the GaussianPyramid since the Laplacian can be 
  % obtained from the Gaussian
  GP = GaussianPyramid(img_bw,i);
  % calculate the Laplacian
  Laplacian = GP - GaussianPyramid(img_bw,i+1);
  % divide figure into grid to print multiple images
  subplot(2,4,i+5), imagesc(Laplacian); 
  colormap(gray);
end

