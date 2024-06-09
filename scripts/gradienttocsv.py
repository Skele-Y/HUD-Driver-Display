# Convert the gradient y=1-100 image into csv
from PIL import Image
import numpy as np
import csv

data = []
im = Image.open("../resources/images/gradient.png")
pixel = im.load()

#width height 
w, h = im.size
x = 0

#pixel index starts at 0
#width index starts at 1
#row_dat = [1,1]
while x+1 <= w:
    row_dat = [x+1,1]
    row_dat.extend(pixel[x,0])
    data.insert(x, row_dat)
    x = x + 1

#add to CSV
with open("gradient.csv",'w') as out:
    csv_out = csv.writer(out)
    csv_out.writerow(['X','Y','R','G','B'])
    for row in data:
        csv_out.writerow(row)