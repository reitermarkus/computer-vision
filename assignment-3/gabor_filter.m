% Parameters: n -> Size of filter
%             sigma_y and sigma_x -> Sigma values for x and y coords.
%             theta -> Orientation of the Gabor filter
%             x0, y0 -> Center coordinates
% Output:     g_even -> Even part of Gabor filter
%             g_odd -> Odd part of Gabor filter

function [g_even, g_odd] = gabor_filter(n, sigma_y, sigma_x, theta, pr, x0, y0)
  if length(n) > 1
    incx = 2 * n / (n(1) - 1);
    incy = 2 * n / (n(2) - 1);
  else
    incx = 2 * n / (n - 1);
    incy = 2 * n / (n - 1);
  end

  [X,Y] = meshgrid(-n:incx:n, -n:incy:n); % this creates x and y coordinates
  xp = (X - x0) * cos(theta) + (Y - y0) * sin(theta); % this controls the orientation
  yp = -(X - x0) * sin(theta) + (Y - y0) * cos(theta);

  g_even = 1 ./ (2 * pi * sigma_x * sigma_y) .* exp(-.5 * ((xp).^2 ./ sigma_x^2 + (yp).^2 ./ sigma_y^2)) .* cos(2 * pi / (4 * sigma_x) * pr .* xp); % Even part of Gabor filter
  g_odd = 1 ./ (2 * pi * sigma_x * sigma_y) .* exp(-.5 * ((xp).^2 ./ sigma_x^2 + (yp).^2 ./ sigma_y^2)) .* sin(2 * pi / (4 * sigma_x) * pr .* xp); % Odd part of Gabor filter
end
