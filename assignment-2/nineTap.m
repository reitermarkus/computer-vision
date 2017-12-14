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

  for col = 1 : size(video, 2)
    column = squeeze(video(:, col, :));

    column_1 = conv2(column, f1);
    column_2 = conv2(column, f2);

    frame = column_1 .* column_2;

    frames = cat(3, frames, frame);
  end

  motion = permute(frames, [1, 3, 2]);
end
