# ☁️ Cloud Detection ☁️

## Acknowledgements

UC Berkeley Statistic 154 (Modern Statistical Prediction and Machine Learning) Spring 2019 Project 2. Based on the paper [Daytime Arctic Cloud Detection Based on Multi-Angle Satellite Data with Case Studies by Yu et al. (2008)](https://github.com/janiceji/cloud-detection/blob/main/yu2008.pdf). The write-up was completed by Janice Ji and YiNung Huang.

## Table of Contents
```
1 Data Collection and Exploration
  a. Data Summary
  b. Maps
  c. EDA
2 Preparation
  a. Data Split
  b. Establishing a baseline (to demonstrate non-triviality of classification)
  c. Feature selection
  d. Cross-Validation
3 Modeling
  a. Classifiers
  b. ROC Curves
  c. Other relevant metrics
4 Diagnostics
  a. Choosing the best classfier
  b. Misclassification errors
  c. Better model?
  d. Other splitting methods
  e. Conclusion
 ```

## Motivation
According to the paper, the ability to detect clouds in polar regions can aid scientists and reserachers gain an understanding about our changing global climate, where the presence of water vapor is leading to increasing temperature and carbon dioxide concentration in the atmosphere. The cloudy surface being similar on the surface to the cloudy/icy surfaces is making the research difficult. From the MISR (multi-angle imaging spectroradiometer) data collection, we gain information from nine angles (with five forward angles in the data), which we will analyze here through visualizations and building several machine learning classification models to determine the best classifier for future unseen image pixels.

## Part 1: Data Collection and Exploration
In this project, we will be taking a look at three datasets, "image1.txt", "image2.txt", and "image3.txt", containing information collected by a cloud detection algorithm.

* ``x-coordinate``: horizontal map coordinate
* ``y-coordinate``: vertical map coordinate
* ``expert label``: expert's classification of pixel
* ``NDAI``: normalized distance angular index (data adaptive)
* ``SD``: standard deviation of An camera pixel values
* ``CORR``: correlation of MISR images of same scene from different viewing directions
* ``radiance angle DF``: raw radiance angle #1 (70.5 degrees)
* ``radiance angle CF``: raw radiance angle #2 (60.0 degrees)
* ``radiance angle BF``: raw radiance angle #3 (45.6 degrees)
* ``radiance angle AF``: raw radiance angle #4 (26.1 degrees)
* ``radiance angle AN``: raw radiance angle #5 (0 degrees/nadir)

## Part 2: Preparation 
The expert labels with 0 are taken out because they contain no information. We test two ways to split the data
The first splitting method involves dividing up the data into 20 blocks to account for dependencies and non-iid among the different images, selecting 70% for training and the other 30% for validation and testing. (Method A).
The second splitting method is to simply split it by image number, where image 1 is the training, image 2 is the validation, and image 3 is the test. (Method B)

#### CVgeneric function 
We chose some classification methods and created a function that allows the user to input one of the following classifiers: logistic regression, LDA, QDA, and KNN, which outputs the respective accuracies and K-fold cross validation loss.

## Part 3: Modeling
After assessing the fit using cross validation, we apply the CVGeneric function on training sets A and B, rename the expert labels to 0 (non-cloudy) and 1 (cloudy), then proceed to model and predict accordingly.

#### ROC Curves
![roc1](https://github.com/janiceji/cloud-detection/blob/main/plots/roc.png)

## Part 4: Diagnostics
Analyzed the proposed best model and examine the misclassification errors.

#### Conclusion
QDA was deemed the best classifier among the ones selected for unseen image pixels.

## R Packages Used
- ggplot2
- corrplot
- caret
- MASS
- class
- ROCR
- gridExtra
