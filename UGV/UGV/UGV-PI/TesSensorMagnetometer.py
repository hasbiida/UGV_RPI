#/bin/python
import time
from SensorMagnetometer import MagnetometerHMC

if __name__=="__main__":
	print "Tes Magnetometer"
	Magnetometer=MagnetometerHMC()
	while True:
		print Magnetometer.data(),Magnetometer.read_raw()
		time.sleep(0.1)	
		
			
