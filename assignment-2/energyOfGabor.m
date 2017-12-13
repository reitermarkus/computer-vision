function energy = energyOfGabor(video, gabor_size, sigma, theta)
  [g_even, g_odd] = gaborFilter(gabor_size, sigma, sigma, theta, 2, 0, 0);
  
  frames = [];
  
  frameNumber = size(video);
    
  for i = 1 : frameNumber(3)
    image = squeeze(video(:,:,i));
        
    image_even = conv2(double(image), g_even, 'same');
    image_odd = conv2(double(image), g_odd, 'same');
    
    frame = sqrt(image_even.^2 + image_odd.^2);
    frame = im2uint8(frame);

    
    frames = cat(3, frames, frame); 
  end
  
  energy = frames;
end
