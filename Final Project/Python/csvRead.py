from numpy import genfromtxt

my_data = genfromtxt('Train.csv', delimeter=',')

# This will extract all labels in the first row
labels = my_data[:, 0]


# This will grab the image from row i
image = my_data[i, 1:]

# This will extract the wavelets from each image
cA, (cH, cV, cD) = pywt.dwt2(image, 'db1')


#This will reshape a horizontal array into a vertical array (think labels)
# x is the number of rows needed. This is equal to the total sample size
labels = numpy.reshape(my_data[:, 0], (x, 1))


