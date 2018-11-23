#/bin/python
from GpsSensor import GpsPoller
import os
import sys
import time
print "tes GPS"
if __name__=="__main__":
	print "Gps Testing"
	gpsSensor=GpsPoller()
	gpsSensor.running=True
	gpsSensor.start()
	GpsStatus=gpsSensor.status()
	print GpsStatus
	try:
		while True:
			print gpsSensor.data()
			time.sleep(1) #set to whatever

#			os.system('clear')
#			gpsd=  gpsSensor.data()
#			print
#			print ' GPS reading'
#			print '----------------------------------------'
#			print 'latitude    ' , gpsd[1]
#			print 'longitude   ' , gpsd[2]
#			print 'time utc    ' , gpsd[0]
#			print 'altitude (m)' , gpsd[3]
#			print 'speed (m/s) ' , gpsd[4]
#			print 'track       ' , gpsd[5]
#			print 'mode        ' , gpsd[6]
#			print
#			print 'sats        ' , gpsd[7]
			
			
	except (KeyboardInterrupt, SystemExit): #when you press ctrl+c)
		print "Threaad Kill"
		gpsSensor.running=False
		gpsSensor.join()
		print "Finish"
