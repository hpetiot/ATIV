from xmlrpc.client import FastMarshaller
import cv2 as openCV

keble_a = openCV.imread("Introduction_to_CV/Lab3/keble/keble_a.jpg");
keble_b = openCV.imread("Introduction_to_CV/Lab3/keble/keble_b.jpg");
keble_c = openCV.imread("Introduction_to_CV/Lab3/keble/keble_c.jpg");

fastA = openCV.FastFeatureDetector_create();
fastB = openCV.FastFeatureDetector_create();
fastC = openCV.FastFeatureDetector_create();

featureA = fastA.detect(keble_a, None);
featureB = fastB.detect(keble_b, None);
featureC = fastC.detect(keble_c, None);

list_fA = list(featureA);
for elem in list_fA:
    print(elem.pt);

# idea : feature point into sift.to match them + re-read courswork on Ransack.