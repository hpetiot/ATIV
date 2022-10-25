from xmlrpc.client import FastMarshaller
import cv2 as openCV
import numpy as np
from numpy import Infinity

keble_a = openCV.imread("Introduction_to_CV/Lab3/keble/keble_a.jpg")
keble_b = openCV.imread("Introduction_to_CV/Lab3/keble/keble_b.jpg")
keble_c = openCV.imread("Introduction_to_CV/Lab3/keble/keble_c.jpg")

grey_a = openCV.imread("/home/hugo/Desktop/ATIV/Introduction_to_CV/Lab3/keble/keble_a.jpg", openCV.IMREAD_GRAYSCALE)
grey_b = openCV.imread("/home/hugo/Desktop/ATIV/Introduction_to_CV/Lab3/keble/keble_a.jpg", openCV.IMREAD_GRAYSCALE)
grey_c = openCV.imread("/home/hugo/Desktop/ATIV/Introduction_to_CV/Lab3/keble/keble_a.jpg", openCV.IMREAD_GRAYSCALE)

#using FAST
def usingFast(a, b, c):
    fastA = openCV.FastFeatureDetector_create()
    fastB = openCV.FastFeatureDetector_create()
    fastC = openCV.FastFeatureDetector_create()

    featureA = fastA.detect(a, None)
    featureB = fastB.detect(b, None)
    featureC = fastC.detect(c, None)

    return featureA, featureB, featureC

def usingSift(a, b, c):
    siftA = openCV.SIFT_create()
    siftB = openCV.SIFT_create()
    siftC = openCV.SIFT_create()

    featureA = siftA.detectAndCompute(a, None)
    featureB = siftB.detectAndCompute(b, None)
    featureC = siftC.detectAndCompute(c, None)
    return featureA, featureB, featureC

def usingHarris(keble_a, keble_b, keble_c):
    # as this method does not yield point coordinates, I will not use it in the rest of the TP.
    grey_a = openCV.cvtColor(keble_a, openCV.COLOR_BGR2GRAY)
    grey_b = openCV.cvtColor(keble_b, openCV.COLOR_BGR2GRAY)
    grey_c = openCV.cvtColor(keble_c, openCV.COLOR_BGR2GRAY)
   
    harris_a = openCV.cornerHArris(grey_a, 4, 3, 0.04)
    harris_b = openCV.cornerHArris(grey_a, 4, 3, 0.04)
    harris_c = openCV.cornerHArris(grey_a, 4, 3, 0.04)

def matchAndRansac(descriptor_one, descriptor_two, kp1, kp2):
    matches = openCV.BFMatcher().knnMatch(descriptor_one, descriptor_two, k=2)
    left = np.float32([kp1[i].pt for i in range(0, len(kp1))]).reshape(-1, 1, 2)
    right = np.float32([kp2[i].pt for i in range(0, len(kp2))]).reshape(-1, 1, 2)

    M, mask = openCV.findHomography(left, right, openCV.RANSAC, 5.0)
    return M

fA, fB, fC = usingSift(grey_a, grey_b, grey_c)
kpA, descA = fA
kpB, descB = fB
kpC, descC = fC
M_AtoB = matchAndRansac(descA, descB, kpA, kpB)
M_CtoB = matchAndRansac(descC, descB, kpC, kpB)
print(M_AtoB)
print(M_CtoB)

# question @teach' : 
#   -> witch part are we supposed to actualy code ourselves (feature finding, feature matching, Ransack)
# idea : feature point into sift.to match them + re-read courswork on Ransack.