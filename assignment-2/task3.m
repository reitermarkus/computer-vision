reader = VideoReader('ball.mp4');

frames = [];

while hasFrame(reader)
  frame = readFrame(reader);

  % convert to grayscale
  frame = rgb2gray(frame);

  frames = cat(3, frames, frame);
end

output = gaborEnergy(frames, 9, 9, 5, pi / 6);
% output = nineTap(frames);

implay(output);
