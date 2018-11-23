#/bin/python
'''
@author : estheim
Controler for mode manual and auto
make a command to send use SerialM8 module

'''
from SerialM8 import SerialM8
import time

class Controler:
	def __init__(self,mode):
		self.mode = mode
		self.master = SerialM8()
		self.dataSerial=[]
	def manual(self,pwml,pwmr,left,right):
		if self.mode =="manual":
			if pwml>255:
				pwml=255
			if pwmr>255:
				pwmr=255
			if pwml<200:
				pwml=200
			if pwmr<200:
				pwmr=200
			command = "$master,%s,%s,%i,%i" %(pwml,pwmr,left,right)
			self.dataSerial=self.master.SerialSend(command)
			#print time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime()),self.dataSerial
			return self.dataSerial
		else:
			self.dataSerial=['','','']
			return self.dataSerial
		
		
if __name__=="__main__":
	pass
