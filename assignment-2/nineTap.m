function motion = nineTap(video)  
  f1 = [
    0.0094,  0.1148,  0.3964
   -0.0601, -0.9213, -0.0601 
    0.3964,  0.1148,  0.0094
  ];
  f2 = [
    0.0008, 0.0176, 0.1660
    0.6383, 1.0,    0.6383
    0.1660, 0.0176, 0.0008
  ];
  
  frames = [];
  
  video = permute(video, [1, 3, 2]);
          
  for row = 1 : size(video, 3)
    image = squeeze(video(:, :, row));
        
    image_1 = conv2(double(image), f1, 'same');
    image_2 = conv2(double(image), f2, 'same');
    
    frame = image_1 .* image_2;
    frame = im2uint8(frame);
    
    frames = cat(3, frames, frame); 
  end
  
  video = frames;
 
  motion = permute(video, [1, 3, 2]);
end

