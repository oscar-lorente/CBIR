# CBIR
Content-Based Image Retrieval system

Design, implementation and evaluation of a content-based image recovery algorithm (CBIR), using an image identification and retrieval system based on the comparison of histograms of gray levels and an algorithm based on a color descriptor in the MPEG7 standard: Color Layout Descriptor (CLD), designed to capture the spatial distribution of colors in an image efficiently through discrete cosine transform (DCT). 

From a database of 2000 images, the system retrieves the 10 most similar to one chosen by the user (query) and, later, calculates the precision-recall curve, together with the Fscore, in order to evaluate the Performance and accuracy of the algorithm used (MAE, MSE, Chi-Square or Bhattacharyyadistance). Although attempts will be made to improve the results of identification of images of the system, the optimization and execution time of the system will also be taken into account, together with the volume (MB) occupied by the descriptors used, in order to find the algorithm that gives the most accurate results and at the same time suppose the lowest computational load.

The block diagram of the implemented system is as follows:

![image](https://user-images.githubusercontent.com/42140425/71124730-c5eb9700-21e5-11ea-8ff0-3464949aa2fb.png)
