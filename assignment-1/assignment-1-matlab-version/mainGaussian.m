img = imread('You.jpg','JPG'); 

for i = 1 : 4
  % get GaussianPyramid
  GP = GaussianPyramid(img_bw,i);
  % divide figure into grid to print multiple images
  subplot(2,4,i), imagesc(GP); 
  colormap(gray);
end

