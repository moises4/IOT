import pywt

# This will extract the wavelets from each image
cA, (cH, cV, cD) = pywt.dwt2(image, 'db1')