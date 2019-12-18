# Content-Based Image Retrieval system

Design, implementation and evaluation of a content-based image recovery algorithm (CBIR), using an image identification and retrieval system based on the comparison of histograms of gray levels and an algorithm based on a color descriptor in the MPEG7 standard: Color Layout Descriptor (CLD), designed to capture the spatial distribution of colors in an image efficiently through discrete cosine transform (DCT). 

From a database of 2000 images, the system retrieves the 10 most similar to one chosen by the user (query) and, later, calculates the precision-recall curve, together with the Fscore, in order to evaluate the Performance and accuracy of the algorithm used (MAE, MSE, Chi-Square or Bhattacharyyadistance). Although attempts will be made to improve the results of identification of images of the system, the optimization and execution time of the system will also be taken into account, together with the volume (MB) occupied by the descriptors used, in order to find the algorithm that gives the most accurate results and at the same time suppose the lowest computational load.

The block diagram of the implemented system:

![image](https://user-images.githubusercontent.com/42140425/71124730-c5eb9700-21e5-11ea-8ff0-3464949aa2fb.png)

The system is based on 3 blocks: Feature extraction of each image (the descriptors: histograms of gray levels or Color Layout Descriptor), the calculation of the distance between the characteristics of the image to be compared and those of the database, and finally, the decision maker and indexer of the images in order of similarity; which is explained in detail below.

## CBIR system by using Color Layout Descriptor (CLD)
CLD block diagram:

![image](https://user-images.githubusercontent.com/42140425/71125540-6c846780-21e7-11ea-9f05-40ae9f8ca07d.png)

### Algorithm Design
#### Image division
The algorithm divides the original image (the 3 matrices that compose it: RGB) into 64 blocks of size M / 8 * N / 8 (being the original image of dimensions MxN) to guarantee the invariability of its resolution:

![image](https://user-images.githubusercontent.com/42140425/71125936-2d0a4b00-21e8-11ea-85ec-437812246f07.png)

#### Selection of the most representative color
For each of the 64 blocks obtained by dividing the image, the most representative color of each block is identified by calculating the average of all the pixels that compose it.

At the end of this process we obtain an image of 8 x 8 (3 matrices of 8x8, RGB), since the blocks of M / 8 x N / 8 that we had at the entrance of the process have been reduced to a single pixel value by block:

![image](https://user-images.githubusercontent.com/42140425/71126058-7eb2d580-21e8-11ea-984f-d7a098b6d704.png)

#### DCT 
Once the 8x8 image with the most representative colors is obtained, a RGB color space transformation is made to the YCbCr (luminance and chrominance), to finally apply the discrete cosine transform (DCT), resulting in 3 matrices of 64 coefficients DCT each.

The DCT is defined by the following expressions:

![image](https://user-images.githubusercontent.com/42140425/71126146-b457be80-21e8-11ea-8818-2ab40ddb8c8a.png)

#### Zigzag scan
Finally, a Zigzag exploration of the DCT coefficients of each of the previously obtained YCbCr color spaces is performed, because the first transformation coefficients are those corresponding to the low frequencies, which we would like to keep for on top of the rest, as they contain more relevant information about the image. 

At the exit of the scan you can choose the number of luminance and chrominance coefficients that you want to use when implementing the algorithm, with 18 coefficients (6 of each: Y, Cb and Cr) the value chosen by us as a compromise between good performance and computing speed).

![image](https://user-images.githubusercontent.com/42140425/71126296-026cc200-21e9-11ea-84b3-4fe71e354753.png)

#### Matching
Once the zigzag scan has been performed, 3 characteristic vectors (Y, Cb and Cr, of 6 coefficients each) are obtained with the most important components of each space, and by the following expression:

![image](https://user-images.githubusercontent.com/42140425/71126368-25977180-21e9-11ea-9574-2fa4b78e2ccc.png)

The value D is obtained, which represents the distance between two images to be compared: the smaller it is, the more similar the corresponding images will be. The elements wyi, wbi and wri are weights to choose that will determine the contribution of the components of each of the 3 vectors to the matching result.

### System results
The implemented system has the following precision-recall curve, with an F-score value of 0.65:

![image](https://user-images.githubusercontent.com/42140425/71126530-7ad38300-21e9-11ea-9bb7-bc013d56b6cf.png)

Computational cost (Intel Core i7-7500U, de 2.7 GHz):

![image](https://user-images.githubusercontent.com/42140425/71126610-a3f41380-21e9-11ea-8770-7b308bf0428a.png)

## CBIR system by using Histograms of gray levels
### Feature Extraction
The feature extraction of all images is implemented by means of an algorithm that extracts the descriptors of each image and stores its values in a matrix of dimension NxM, being N the number of images to be analyzed (2000 in this case) and M the number of levels of gray (bins) used in the representation of the histogram:

![image](https://user-images.githubusercontent.com/42140425/71125182-cf293380-21e6-11ea-80ef-84ecd5dd9f3f.png)

### Distance
Once the database is indexed, and therefore, the descriptors of the corresponding images are obtained (together with the descriptor of the query image), the degree of similarity between the histogram of the image to be analyzed and everything else is calculated, using the use of different methods, all based on the bin-to-bin comparison.

#### Mean Absolute Error (MAE)
Represents the average of the absolute differences between the pixel level at a specific bin of two histograms, where all individual differences have the same weight:

![image](https://user-images.githubusercontent.com/42140425/71126815-106f1280-21ea-11ea-8356-4d2e70f9d4be.png)

#### Mean Squared Error (MSE)
In order to observe the behavior of the system using a method based on the bin-to-bin comparison and which penalizes the largest errors (Squared), the mean squared error has been implemented as a technique to calculate the distance between two histograms. This measure, though, is normally used to evaluate the quality of a predictor or estimator, although in this context it can be interpreted as the measure of the distance between two 2 histograms (2), in a similar way as calculated by Euclidean distance (3).

![image](https://user-images.githubusercontent.com/42140425/71126975-63e16080-21ea-11ea-8012-ebfde51f86bc.png)

#### Chi-square distance
It is a type of weighted Euclidean distance (each term has a weight that is inverse to its frequency) that obtains the distance between two normalized histograms with the same number of bins, n. The name of the distance is derived from the statistics of Pearson's chi squared, used to compare discrete probability distributions (ie, histograms).

![image](https://user-images.githubusercontent.com/42140425/71127148-c8042480-21ea-11ea-89b5-f8e8a0a05dd8.png)

#### Bhattacharyya distance
measure the similarity of two probability distributions. This distance is closely related to the Bhattacharyya coefficient, which is a measure of the amount of overlap between two statistical samples or populations, and is therefore used to determine the relative proximity of the two samples considered.

![image](https://user-images.githubusercontent.com/42140425/71127232-f71a9600-21ea-11ea-9740-dd89ec95992c.png)

### Decision
The decision block bases its operation on an algorithm responsible for extracting the 10 images most similar to the query image. Basically, it orders the images of the database in ascending order according to the result obtained in the previous block, and then takes the first 10 images of the resulting list, corresponding to those that have a smaller distance from the query (being the same query image the first in the list, with distance 0).

Example (first image: query image):

![image](https://user-images.githubusercontent.com/42140425/71127381-4d87d480-21eb-11ea-8ded-e48fe3d96d94.png)

![image](https://user-images.githubusercontent.com/42140425/71127431-67c1b280-21eb-11ea-93f7-f679b4f1022f.png)

### Avaluation
Precision/recall curve and (max) F-score of 0.557:

![image](https://user-images.githubusercontent.com/42140425/71127491-7f993680-21eb-11ea-961b-0b04fb44b239.png)

Time it takes for the system to index the images in the database, that is, to calculate and obtain the descriptors corresponding to each image, in addition to the volume (MB) that each of them occupies, all depending on the number of bins (or gray levels):

![image](https://user-images.githubusercontent.com/42140425/71127585-a8b9c700-21eb-11ea-8df7-afa76f2d7ea4.png)

Time it takes for each algorithm (Bhattacharyya, Chi-Square,
MSE and MAE) in finding the 10 images corresponding to the most similar for the 20 query images of an input.txt.

![image](https://user-images.githubusercontent.com/42140425/71127797-05b57d00-21ec-11ea-822d-c954038a05d5.png)

Comparison of time according to the number of bins used for the descriptors, for the Bhattacharyya distance algorithm

![image](https://user-images.githubusercontent.com/42140425/71127808-0cdc8b00-21ec-11ea-8fac-ae9c2f6ed86d.png)
