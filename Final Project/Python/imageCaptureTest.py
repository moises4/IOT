import cv2
import pywt
import numpy
from scipy.misc import toimage
from PIL import Image
from resizeimage import resizeimage


cam = cv2.VideoCapture(0)

cv2.namedWindow("test")

img_counter = 0

while True:
    ret, frame = cam.read()
    cv2.imshow("test", frame)
    if not ret:
        break
    k = cv2.waitKey(1)

    if k%256 == 27:
        # ESC pressed
        print("Escape hit, closing...")
        break

    elif k%256 == 32:
        # SPACE pressed
        img_name = "opencv_frame_{}.png".format(img_counter)

        image = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)


        # Attempting to resize image to reduce the amount of data being passed around
        #image = resizeimage.resize_cover(image, [320, 240], validate=False)

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

        finalArray = numpy.concatenate((cA, cH, cV, cD), axis=1)

        img_counter += 1

        print "size of image: %d by %d" % (len(image[0]), len(image))

        print "cA array size: %d" % (len(cA[0]))

        print "Final array size: %d" % (len(finalArray[0]))

        print finalArray

        print("{} written!".format(img_name))

cam.release()

cv2.destroyAllWindows()