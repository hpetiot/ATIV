# Part 1:
### Is moving average shift invariant ?
    Yes: the average of an image conserves the result when the image is shifted, the result is shifted too.
### Is thresholding shift-invarient?
    Yes same idea as moving average.
### Is moving average linear ?
    Yes the average smooths values therefore we can derivate it everywhere.
### Is thresholding linear ?
    No, the point of a threshold is to break the curve of color distribution. Therefore the result is not linear.
-> take a matrix exemple on paper. don't bother coding it.
# Part 2:
The difference between the gaussian filter and the moving average filter is that gausssian filter preserves the edges and blurs the details but is not visibly blurred compared to the moving average where we get enought blur be it on the edges or the details that we get the impression of having the wrong prescrition glasses.
# Part 3:

# Assignment: 
p1 : 
shift invariance : show effect + image or normal matrix

linearity : take 2 signals(5x5) =f1 and f2, check that f1\*A + f2\*B = f3 with a & b scalare apply MovingAverage on f3. should be same as MovingAverage on a\*f1 + MA b\*f2.

do p2 -> p4 

use cany on compressed images from tp1 but use cany as pressision for compression discriminators
