import cv2
import pywt
import numpy as np
import csv
from scipy.misc import toimage
from PIL import Image
from resizeimage import resizeimage
import boto3
import pandas as pd
import io
import AWSKeys

finalArray = [0] * (2376 * 4)

cam = cv2.VideoCapture(0)

# Set webcam resolution
cam.set(3,320)
cam.set(4,240)

cv2.namedWindow("test")

img_counter = 0

print AWSKeys.secretKey

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

        height, width = image.shape[:2]

        # Resize webcam image
        #image = cv2.resize(image, (320, 240)) 

        coeffs = pywt.wavedec2(image, 'bior6.8', level=3)

        [cA, (cH, cV, cD), (cH2, cV2, cD2), (cH3, cV3, cD3)] = coeffs

        x = len(cA);
        y = len(cA[0])
        size = x * y

        #print size*4

        #toimage(cA).show()
        cA = cA.flatten()

        #toimage(cH).show()
        cH = cH.flatten()

        #toimage(cV).show()
        cV = cV.flatten()

        #toimage(cD).show()
        cD = cD.flatten()

        finalArray = np.concatenate((cA, cH, cV, cD), axis=0)

        finalArray = np.around(finalArray, decimals=2)

        finalArray = np.array([finalArray])

        print finalArray

        np.savetxt("export.csv", finalArray, delimiter=", ")


        client = boto3.client('runtime.sagemaker', region_name='us-east-1')

        response = client.invoke_endpoint(
            EndpointName = 'kmeans-2018-04-25-04-35-11-958',
            Body = 'export.csv',
            ContentType = 'text/csv;label_size=1'
        )

        result = response['Body'].read().decode('ascii')



cam.release()

cv2.destroyAllWindows()
