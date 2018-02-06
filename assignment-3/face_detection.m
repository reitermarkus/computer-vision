pkg load image

faces = read_images('./253.faces-easy-101');
clutter = read_images('./257.clutter');

length(faces)
length(clutter)

img = faces{2}

new_image = double(img) * 0;

# Loop through theta 0° – 360°, in steps of 10°.
for i = 0:35
  theta = i * 10 * pi / 180

  energy = energy_of_gabor(img, 15, 10, 10, theta, 2, 0, 0);

  new_image = imadd(new_image, double(energy));
end

new_image = normalize_image(new_image);

imwrite(new_image, 'yolo.jpg');
