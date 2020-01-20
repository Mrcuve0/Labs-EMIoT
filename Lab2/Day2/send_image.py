import serial
import struct
import time
import numpy as np
from PIL import Image

def int_to_bin(x, length=1):
    return x.to_bytes(length, byteorder='big')

ser = serial.Serial()
ser.port = "/dev/ttyACM0"
ser.baudrate = 9600
ser.bytesize = serial.EIGHTBITS
ser.parity = serial.PARITY_NONE
ser.stopbits = serial.STOPBITS_ONE
ser.timeout = 10
ser.xonxoff = False
ser.rtscts = False
ser.dsrdtr = False

ser.open()

im = Image.open('dog.jpg')
#im.show()
im = im.convert('RGB')
pixels = np.asarray(im)
string = b''
print(pixels.shape)
time.sleep(4)
for r in range(pixels.shape[0]-1,-1,-1):
    for c in range(pixels.shape[1]):
        ser.write(int_to_bin(int(pixels[r,c,2]/4)))
        ser.write(int_to_bin(int(pixels[r,c,1]/4)))
        ser.write(int_to_bin(int(pixels[r,c,0]/4)))
ser.flush()
