video = VideoReader('motion.mp4');

frames = [];

while hasFrame(video)
  frame = readFrame(video);
  frames = cat(3, frames, rgb2gray(frame));
end

result = energyOfGabor(frames, 9, 5, pi / 6);
% result = nineTap(frames);

implay(result);
