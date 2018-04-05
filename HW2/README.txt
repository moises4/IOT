
README.txt

1. Download the fer2013.csv dataset and and importfileAsColVectors.m and put it in the current matlab directory.

2. Run HW2.m. this will take the fer2013.csv dataset and output the dbData.csv, coifData.csv, and emotionLabel.csv files into the current directory. 

3. Run normalizedData.m. This will take the wavelet dataset csv's from above and create our hybrid wavelet coefficient matrix and normalize it.
   The file will output the combined dataset ts normalization.csv.

4. You are now ready to run the neural networks. Run db_nn.m to obtain results for the dbData network. Run coif_nn.m to obtain results for the coifData network. .
   Run hybrid_nn.m to obtain results for the normalizedData network.