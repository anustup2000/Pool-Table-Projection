import numpy as np
import cv2

img = cv2.imread('cs10.jpg',1)
imsizex, imsizey = img.shape[:2]
newx = 500
newy = (imsizey/imsizex)*newx
img_res = cv2.resize(img,(newx, newy), interpolation = cv2.INTER_LINEAR)
cv2.imshow('image',img_res)
image = cv2.normalize(img.astype('float'), None, 0.0, 1.0, cv2.NORM_MINMAX) # im2double
r,c,p = image.shape
imR = image(:,:,1)
imG = image(:,:,2)
imB = image(:,:,3)	

img = PictureMask(image)
newimg = np.zeros((img.shape), dtype = "uint8")
circles = cv2.HoughCircles(img,cv2.HOUGH_GRADIENT,1,20,param1=50,param2=30,minRadius=5,maxRadius=20)
circles = np.uint16(np.around(circles))
for i in circles[0,:]:
    cv.Circle(img, center, radius, (255,255,255), thickness=-1, None, shift=0)
    cv2.circle(cimg,(i[0],i[1]),i[2],(0,255,0),2)
    # draw the outer circle
ret, imbin = cv2.threshold(img,127,255,cv2.THRESH_BINARY)
labels,numlabels = label(imbin)

rlabel = np.zeros((r,c),dtype = "uint8")
glabel = np.zeros((r,c),dtype = "uint8")
blabel = np.zeros((r,c),dtype = "uint8")

for i in range(1,numlabels):
	numpy.median(imR(labels==i), out = rlabel(labels==i))
	numpy.median(imG(labels==i), out = glabel(labels==i))
	numpy.median(imB(labels==i), out = blabel(labels==i))
imlabel=array([rlabel],[glabel],[blabel)


cv2.waitKey(0)

 	