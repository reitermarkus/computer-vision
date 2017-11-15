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

  // Reads a jpg image and converts it to grayscale
  Mat image = imread(argv[1], 0);
  image.convertTo(image, CV_32F);

  vector<double> theta = {0, M_PI / 4.0, M_PI / 2.0, 3.0 * M_PI / 4.0}; // 4 orientations for the size of the filter
  int n = 15;
  Size gsize = {n, n};

  foreground();

  Mat combined = Mat::zeros(336, 448, CV_8U);
  resize(combined, combined, Size(336, 448));

  for (int i = 1; i <= 4; i++) {
    Mat fimage, respf;

    Mat gkernel = getGaborKernel(gsize, 10, theta[i], 10.0, 1.0, 0.0); // apply Gabor

    // Convolute image with Gabor filter.
    // filter2D computes correlation.
    // For convolution the kernel has to be fliped horizontally.
    flip(gkernel, gkernel, 1);
    filter2D(image, respf, CV_64F, gkernel, Point(-1,-1));

    namedWindow("Gabor filter " + to_string(i), WINDOW_AUTOSIZE);
    moveWindow("Gabor filter " + to_string(i), (i - 1) * 336, 0);
    namedWindow("Image " + to_string(i), WINDOW_AUTOSIZE);
    moveWindow("Image " + to_string(i), (i - 1) * 336, 448 + 44);

    // Show Gabor filter
    flip(gkernel, gkernel, 1);
    resize(gkernel, gkernel, Size(336, 448));
    imshow("Gabor filter " + to_string(i), gkernel);

    // Show filtered Image
    normalize(respf, fimage, 0, 255.0, NORM_MINMAX);
    fimage.convertTo(fimage, CV_8U);
    imshow("Image " + to_string(i), fimage);

    add(fimage / 4.0, combined, combined);
  }

  resize(combined, combined, Size(336, 448));

  namedWindow("Combined filters", WINDOW_AUTOSIZE);
  moveWindow("Combined filters", 4 * 336, 0);
  imshow("Combined filters", combined);

  waitKey(0); // Wait for a keystroke in the window.
  return EXIT_SUCCESS;
}
