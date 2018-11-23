
from Cmps03 import Cmps03
import time
while True:
	compass=Cmps03()
	print compass.data()
	time.sleep(0.1)
