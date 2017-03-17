import numpy as np
import cv2
def createMask(RGB):
# Convert RGB image to chosen color space
I = cv2.cvtColor(RGB, cv2.COLOR_BGR2HSV)
# Define thresholds for channel 1 based on histogram settings
channel1Min = 0.528
channel1Max = 0.844

# Define thresholds for channel 2 based on histogram settings
channel2Min = 0.100
channel2Max = 1.000

# Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000
channel3Max = 1.000

BW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max,dtype = int)


maskedRGBImage = RGB

maskedRGBImage(np.tile(~BW,[1 1 3])) = 0