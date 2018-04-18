import cv2
import pywt
import numpy
import csv
from scipy.misc import toimage
from PIL import Image
from resizeimage import resizeimage
from numpy import genfromtxt


finalArray = [0] * (2376 * 4 + 1)
wavelets = []




with open("/home/graves/CSVFiles/ResizeTrain.csv", "r") as f:
    reader = csv.reader(f, delimiter=',')
    for i, line in enumerate(reader):

        label = []

        label.extend((map(int, line[0])))


        readLine = map(int, line[1:])


        readImage = numpy.reshape(readLine, [240, 320])


        coeffs = pywt.wavedec2(readImage, 'bior6.8', level=3)

        [cA, (cH, cV, cD), (cH2, cV2, cD2), (cH3, cV3, cD3)] = coeffs


        x = len(cA);
        y = len(cA[0])
        size = x * y

        #toimage(cA).show()
        cA = cA.flatten()

        #toimage(cH).show()
        cH = cH.flatten()

        #toimage(cV).show()
        cV = cV.flatten()

        #toimage(cD).show()
        cD = cD.flatten()


        wavelets = numpy.concatenate((label, cA, cH, cV, cD), axis=0)

        wavelets = wavelets.flatten()

        # finalArray = numpy.concatenate((finalArray, wavelets), axis = 0)

        finalArray = numpy.vstack((finalArray, wavelets))

        # finalArray = finalArray.flatten()

        print "Image %d compeleted!" % (i)
    
finalArray = numpy.delete(finalArray, 0, 0)

print finalArray



numpy.savetxt("wavelets.csv", finalArray, delimiter=",")