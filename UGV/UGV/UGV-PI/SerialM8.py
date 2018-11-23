#/bin/python
import serial
import re

class SerialM8:
	def __init__(self):
		self.ser=serial.Serial('/dev/ttyAMA0',9600)
		self.lsdataserial=[]

	def SerialSend(self,command):
		self.ser=serial.Serial('/dev/ttyAMA0',9600)
		#print command
		command = ("%s\r\n") %(command)
		self.ser.write(command)
		#self.ser.flushInput()
		for i in range(3):#get 3 line serial
			#print "kirim %i" % (i)
			temp = self.ser.readline()
			#print temp
			self.lsdataserial.append(temp.strip()) #append tambah komponen list strip hilangkan \r\n di tiap akhir
		#print self.lsdataserial
		return self.lsdataserial
		self.ser.close() #stop serial
'''
if __name__=="__main__":
	#print("begin")
	controler=SerialM8()
	#print "send serial"
	dataserial=controler.SerialSend("$master,123,123,1,1")
	print dataserial
	(stat,encoderL,encoderR)=controler.GetDataEncoder()
	print (stat,encoderL,encoderR)'''

