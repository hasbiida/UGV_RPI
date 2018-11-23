
#/bin/python
'''
@author : estheim
Controler for mode manual and auto
make a command to send use SerialM8 module

'''
from SerialM8 import SerialM8
from SensorMagnetometer import MagnetometerHMC
from GpsSensor import GpsPoller
import gps
import time
import sys

class Controler:
	def __init__(self,mode):
		self.mode = mode
		self.master = SerialM8()
		self.dataSerial=[]
	def manual(self,pwml,pwmr,left,right):
		if self.mode =="manual":
			command = "$master,%s,%s,%i,%i" %(pwml,pwmr,left,right)
			self.dataSerial=self.master.SerialSend(command)
			print time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime()),self.dataSerial
			time.sleep(5)
		else:
			pass
	def semiauto(self,Heading,Range):
		self.Heading= Heading
		self.Range = Range
		if self.mode =="auto":
			#using gps
			gpsSensor=GpsPoller()
			gpsSensor.running=True
			gpsSensor.start()
			GpsStatus=gpsSensor.status()
			#f.write ("%b", %GpsStatus)
			print GpsStatus
			#using compass
			errorHeading=self.error()
			while (errorHeading>10 or errorHeading<-10):
				if errorHeading > 10:
					command=self.putarkanan()
					self.dataSerial=self.master.SerialSend(command)
				else:
					command=self.putarkiri()
					self.dataSerial=self.master.SerialSend(command)
				errorHeading=self.error()
				#f.write(errorHeading, command)
				print errorHeading, command
				time.sleep(0.1)
			print "lurus"
			while self.Range!=0:
				command=self.maju()
				self.dataSerial=self.master.SerialSend(command)
				#get data encoder
				(statusenc,encL,encR)=self.master.GetDataEncoder()
				errorHeading=self.error()
				print "encoder,%s,%s, %s" %(encL,encR,errorHeading)
				print "GpsData:", gpsSensor.data() #output data gps
				print time.strftime("%Y:%m:%d:%H:%M:%S", time.gmtime()), self.Range, command
				print >> sys.stderr,"encoder,%s,%s, %s" %(encL,encR,errorHeading)
				print >> sys.stderr,"GpsData:", gpsSensor.data() #output data gps
				print >> sys.stderr,time.strftime("%Y:%m:%d:%H:%M:%S", time.gmtime()), self.Range, command
				self.Range-=1
				time.sleep(0.1)
			command=self.stop()
			self.dataSerial=self.master.SerialSend(command)
			gpsSensor.running=False #kill thread GPS
			gpsSensor.join() #wait untill thread finish process
			#f.close #tutup file

		else:
			pass
	
			
	def error(self):
		self.Magnetometer=MagnetometerHMC()
		(MagnetometerHeading,MagnetometerMinute)=self.Magnetometer.data()
		errorHeading = MagnetometerHeading-self.Heading 
		return errorHeading
		
	def putarkanan(self):
		pwml=250
		pwmr=250
		left =1
		right =0
		command ="$master,%s,%s,%i,%i\r\n" % (pwml,pwmr,left,right)
		return command
	def putarkiri(self):
		pwml=250
		pwmr=250
		left =0
		right =1
		command ="$master,%s,%s,%i,%i\r\n" % (pwml,pwmr,left,right)
		return command
	def maju(self):
		pwml=255
		pwmr=255
		left =1
		right =1
		command ="$master,%s,%s,%i,%i\r\n" % (pwml,pwmr,left,right)
		return command
	def stop(self):
		pwml=0
		pwmr=0
		left =1
		right =1
		command ="$master,%s,%s,%i,%i\r\n" % (pwml,pwmr,left,right)
		
if __name__=="__main__":
	print "mode?"
	mode=raw_input()
	if mode=="manual":
		con = Controler(mode="manual")
		print "input pwml"
		pwml=raw_input()
		print "input pwmr"
		pwmr=raw_input()
		con.manual(pwml,pwmr,1,1) #mode manual
	elif mode=="semi":	
		con = Controler(mode="semiauto")
		print "input degrees"
		degr=raw_input()
		print "input range"
		rang=raw_input()
		con.auto(int(degr),int(rang))
	pass
