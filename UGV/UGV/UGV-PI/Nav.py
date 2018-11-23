'''
Created on Apr 16, 2013

@author: estheim
'''
from MagnetometerSensor import MagnetometerHMC
from GpsSensor import GpsPoller


Class Navigation:
	def __init__(self):
		GpsThread = GpsPoller()
		GpsThread.start() #start thread gps
	def CurrentWp(self):
		GpsData.fix.latitude
		GpsData.fix.longitude
	def NextWp(self):
		
	def FinalWp(self):	
		
	def WpData(self):
		return 
	


if __name__ == '__main__':
    pass

