'''
Created on Apr 16, 2013

@author: estheim
sistem navigasi untuk satu step 1 second
'''
from MagnetometerSensor import MagnetometerHMC
from GpsSensor import GpsPoller
from Encoder import SensorEncoder


Class Navigation:
	def __init__(self):
		self.gpsSensor = GpsPoller()
		self.gpsSensor.running=True
		self.gpsSensor.start() #start thread gps
	def NavigateToWp(self):
		

Class FuzzyRule:
	def __init__(self):
	
Class PI_Controler:
	def __init__(self, Kp,Ki):
		self.Kp=Kp
		self.Ki=Ki
		self.Magnetometer=MagnetometerHMC() #start Magnetometer
	def Calculate_error:
		c_heading=
if __name__ == '__main__':
    pass

