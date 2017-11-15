#include <iostream>
#include <math.h>
#include <opencv2/opencv.hpp>

using namespace cv;
using namespace std;

// After calling this, new windows will appear in the foreground.
void foreground() {
  string name = "";
  namedWindow(name, WINDOW_NORMAL);
  Mat img = Mat::zeros(100, 100, CV_8UC3);
  imshow(name, img);
  setWindowProperty(name, WND_PROP_FULLSCREEN, WINDOW_FULLSCREEN);
  setWindowProperty(name, WND_PROP_FULLSCREEN, WINDOW_NORMAL);
  destroyWindow(name);
}

int main(int argc, char **argv) {
  if (argc != 2) {
    cerr << "Error: You need to specify a path to an image!" << endl;
    return EXIT_FAILURE;
  }

  // Reads a jpg image and converts it to grayscale.
  Mat image = imread(argv[1], 0);
  image.convertTo(image, CV_64F);

  foreground();

  Mat gaussian_kernel = getGaussianKernel(2, -1);

  Mat current_image;
  image.copyTo(current_image);

  Mat current_gaussian;
  image.copyTo(current_gaussian);

  Mat new_image;

  // Loop until the image cannot be divided by 2 anymore.
  while (current_image.rows % 2 + current_image.cols % 2 == 0) {
    static auto i = 0;
    Mat output_gaussian;
    Mat output_laplacian;

    current_gaussian.copyTo(output_gaussian);
    output_gaussian.convertTo(output_gaussian, CV_8U);
    resize(output_gaussian, output_gaussian, Size(336, 448), INTER_NEAREST);

    namedWindow("Gaussian " + to_string(i));
    moveWindow("Gaussian " + to_string(i), i * 336, 0);
    imshow("Gaussian " + to_string(i), output_gaussian);

    if (i > 0) {
      Mat laplacian = current_image - current_gaussian;

      laplacian.copyTo(output_laplacian);
      output_laplacian.convertTo(output_laplacian, CV_8U);
      resize(output_laplacian, output_laplacian, Size(336, 448), INTER_NEAREST);

      namedWindow("Laplacian " + to_string(i));
      moveWindow("Laplacian " + to_string(i), i * 336, 448 + 44);
      imshow("Laplacian " + to_string(i), output_laplacian);

      new_image.copyTo(current_image);
    }

    filter2D(current_image, current_gaussian, CV_64F, gaussian_kernel);

    // Create downsampled image with odd rows and columns removed.
    new_image = Mat(current_image.rows / 2, current_image.cols / 2, CV_64F);
    for (int r = 0; r < current_image.rows / 2; r++) {
      for (int c = 0; c < current_image.cols / 2; c++) {
        new_image.at<double>(r, c) = current_image.at<double>(r * 2, c * 2);
      }
    }

    i++;
  }

  waitKey(0); // Wait for a keystroke in the window.
  return EXIT_SUCCESS;
}
