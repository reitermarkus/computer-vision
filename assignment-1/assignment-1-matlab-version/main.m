% Main program to convolve an image with a Gabor filter

theta = [0; pi/4; pi/2; 3*pi/4]; % 4 orientations for the Gabor
img = imread('You.jpg','JPG'); % Read a jpg image of you
img_bw = rgb2gray(img); % Transform into black and white

for i = 1 : 4
  % Apply Gabor function
  [g1 g2] = GaborD(15, 10, 10, theta(i), 2, 0, 0);
  % Show Gabor function
  figure, imagesc(g1); 
  colormap(gray); 
  % 2D convolutions
  conv_images1 = conv2(double(img_bw),g1,'same'); 
  conv_images2 = conv2(double(img_bw),g2,'same'); 
  % Energy of Gabor
  energyOfGabor = sqrt((conv_images1.**2)+(conv_images2.**2));
  orientation{i} = energyOfGabor;
end

% combine images 
part1 = imadd(orientation{1}, orientation{2});
part2 = imadd(orientation{4}, orientation{4});
conv_image = imadd(part1, part2);
figure, imagesc(conv_image);
colormap(gray);

