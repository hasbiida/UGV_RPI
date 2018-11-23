#!/usr/bin/python
#Triple Axis Magnetometer Breakout - HMC5883L
#Honeywell Compass Heading Using Magnetometer

from Adafruit_I2C import Adafruit_I2C
import time
import math

ConfigurationRegisterA = 0x00
ConfigurationRegisterB = 0x01
ModeRegister = 0x02
AxisXDataRegisterMSB = 0x03
AxisXDataRegisterLSB = 0x04
AxisZDataRegisterMSB = 0x05
AxisZDataRegisterLSB = 0x06
AxisYDataRegisterMSB = 0x07
AxisYDataRegisterLSB = 0x08
StatusRegister = 0x09
IdentificationRegisterA = 0x10
IdentificationRegisterB = 0x11
IdentificationRegisterC = 0x12
MeasurementContinuous = 0x00
MeasurementSingleShot = 0x01
MeasurementIdle = 0x03


#for bandung 
degree=0
minute=52

class MagnetometerHMC:
	def __init__(self):
		self.i2c=Adafruit_I2C(address=0x1e, debug=None)#set i2c
		self.i2c.write8(ModeRegister,MeasurementContinuous)#set continuous mode
		i2c=Adafruit_I2C(address=0x1e, debug=None)#set i2c
		#gain set to default 1090lsb +-1,3 Ga degital resolution 0.92 pada reg 0x01

	def read_raw(self):		
		#data=self.i2c.readList(AxisXDataRegisterMSB, 6) #baca raw x y z
		magno_x = self.i2c.readS16(AxisXDataRegisterMSB)#(data[0]<<8) | data[1]
		magno_y = self.i2c.readS16(AxisYDataRegisterMSB)#(data[2]<<8) | data[3]
		magno_z = self.i2c.readS16(AxisZDataRegisterMSB)#(data[4]<<8) | data[5]
		
		if (magno_x == -4096):
			magno_x = None
		else:
			magno_x = round(magno_x * 0.92)
			
		if (magno_y == -4096):
			magno_y = None
		else:
			magno_y = round(magno_y * 0.92)
		
		if (magno_z == -4096):
			magno_z = None
		else:
			magno_z = round(magno_z * 0.92)
			
		return (magno_x, magno_y, magno_z)

	def data(self):
		(scaled_x, scaled_y, scaled_z) = self.read_raw()
		#declination= (degree+minute) * (math.pi/180) #calculate declination
		if scaled_y>0:
			headingDeg = 90 - math.atan2(scaled_x,scaled_y)*180/math.pi
		elif (scaled_y<0):
			headingDeg = 270 - math.atan2(scaled_x,scaled_y)*180/math.pi
		elif (scaled_y==0 and x<0):
			headingDeg = 180
		else:
			headingDeg = 0
		#headingDeg += degree+(minute/60) #for bandung less than 1 degree so not calculate
		degrees = math.floor(headingDeg)
		minutes = round(((headingDeg - degrees) * 60))
		return (degrees, minutes)
	def status(self):
		return True
'''

if __name__=='__main__':
  for i in range(100):
	data=MagnetometerHMC()
	axis = data.read_raw()
	(deg,mint) = data.data()
	time.sleep(0.1)	
	print deg ,mint
'''
