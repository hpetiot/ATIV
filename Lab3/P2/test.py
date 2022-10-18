from xmlrpc.client import FastMarshaller
import cv2 as openCV

keble_a = openCV.imread("Introduction_to_CV/Lab3/keble/keble_a.jpg");
keble_b = openCV.imread("Introduction_to_CV/Lab3/keble/keble_b.jpg");
keble_c = openCV.imread("Introduction_to_CV/Lab3/keble/keble_c.jpg");

#using FAST
def usingFast(keble_a, keble_b, keble_c):
    fastA = openCV.FastFeatureDetector_create()
    fastB = openCV.FastFeatureDetector_create()
    fastC = openCV.FastFeatureDetector_create()

    featureA = fastA.detect(keble_a, None)
    featureB = fastB.detect(keble_b, None)
    featureC = fastC.detect(keble_c, None)

    return featureA, featureB, featureC

def usingSift(keble_a, keble_b, keble_c):
    siftA = openCV.SIFT_create()
    siftB = openCV.SIFT_create()
    siftC = openCV.SIFT_create()

    featureA = siftA.detect()
    featureB = siftB.detect()
    featureC = siftC.detect()
    return featureA, featureB, featureC

def usingHarris(keble_a, keble_b, keble_c):
    grey_a = openCV.cvtColor(keble_a, openCV.COLOR_BGR2GRAY)
    grey_b = openCV.cvtColor(keble_b, openCV.COLOR_BGR2GRAY)
    grey_c = openCV.cvtColor(keble_c, openCV.COLOR_BGR2GRAY)
    # /!\ these are not coordinates.!!
    harris_a = openCV.cornerHArris(grey_a, 4, 3, 0.04)
    harris_b = openCV.cornerHArris(grey_a, 4, 3, 0.04)
    harris_c = openCV.cornerHArris(grey_a, 4, 3, 0.04)




# question @teach' : 
#   -> witch part are we supposed to actualy code ourselves (feature finding, feature matching, Ransack)
# idea : feature point into sift.to match them + re-read courswork on Ransack.