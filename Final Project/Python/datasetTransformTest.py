import cv2
import pywt
import numpy
from scipy.misc import toimage
from PIL import Image
from resizeimage import resizeimage
from numpy import genfromtxt


labels = []
finalArray = []
with open("Train.csv", "r") as f:
    reader = csv.reader(f, delimiter=',')
    for x, line in enumerate(reader):

        readImage = line;
        
        image = cv2.cvtColor(readImage, cv2.COLOR_BGR2GRAY)

        coeffs = pywt.dwt2(image, 'bior3.5')

        cA, (cH, cV, cD) = coeffs

        x = len(cA);
        y = len(cA[0])
        size = x * y

        #toimage(cA).show()
        cA = numpy.reshape(cA, [1, size])

        #toimage(cH).show()
        cH = numpy.reshape(cH, [1, size])

        #toimage(cV).show()
        cV = numpy.reshape(cV, [1, size])

        #toimage(cD).show()
        cD = numpy.reshape(cD, [1, size])

        wavelets = numpy.concatenate((cA, cH, cV, cD), axis=1)

        finalArray = numpy.concatenate((finalArray, wavelets), axis=0)


        print "Image %d compeleted!" % (x)


numpy.savetxt("wavelets.csv", finalArray, delimiter=",")