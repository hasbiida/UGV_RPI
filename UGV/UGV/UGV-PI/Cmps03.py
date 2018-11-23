from Adafruit_I2C import Adafruit_I2C
import time
addresscmps03 = 0x60
BearingRegister = 0x01 #0-255 degrees
BearingRegisterMSB = 0x02 #0-3599 degrees

class Cmps03:
	def __init__(self):
		self.i2c=Adafruit_I2C(address=addresscmps03, debug=None)
	def ReadDataRAW(self):
		#read data register 0x01
		self.bearing255 =self.i2c.readU8(BearingRegister)
		#read 2 register MSB 0x02 and LSB 0x03 bearing=MSB<<8 +LSB
		self.bearing3599 = self.i2c.readS16(BearingRegisterMSB)
		return self.bearing255,self.bearing3599 
	def data(self):
		#data use data bearing 2 for more precition
		bearing=self.ReadDataRAW()
		databearing=bearing[1] # get only bearing 2
		return databearing
	def status(self):
		True

