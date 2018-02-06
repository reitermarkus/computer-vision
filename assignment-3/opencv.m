if ismac()
  [status, output] = system ("brew --prefix mexopencv");
  prefix = strtrim(output)
  addpath([prefix '/lib'])
  addpath('lib/opencv_contrib')
  addpath([prefix '/lib/+cv/private'])                % HACK
  addpath([prefix '/lib/opencv_contrib/+cv/private']) % HACK
end

# cv.getBuildInformation()
