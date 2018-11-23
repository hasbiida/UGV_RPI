#! /usr/bin/python
# Written by Dan Mandle http://dan.mandle.me September 2012
# License: GPL 2.0
# edited by estheim telkom institute teknologi

import os
from gps import *
from time import *
import time
import threading
 
GpsData = None #seting the global variable
 
class GpsPoller(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        global gpsd #bring it in scope
        gpsd = gps(mode=WATCH_ENABLE) #starting the stream of info
        self.current_value = None
        self.running = True #setting the thread running to true
    def run(self):
		global gpsd
		while self.running: #cek thread true
			gpsd.next()  #this will continue to loop 
    def status(self):
        #return nilai 
        if (len(psd.satellites) > 4):
            return True
        else:
            return False
    def data(self):
        return gpsd.utc,gpsd.fix.latitude,gpsd.fix.longitude,gpsd.fix.altitude, gpsd.fix.speed,gpsd.fix.track, gpsd.fix.mode, len(gpsd.satellites)
 
'''

if __name__ =="__main__":
	gpsSensor=GpsPoller()
	gpsSensor.start()
	GpsStatus=gpsSensor.status()
	for i in range(10):
		print "1",gpsd.fix.latitude,gpsd.fix.longitude,gpsd.fix.altitude,len(gpsd.satellites)
		print "2",gpsSensor.data()
		time.sleep(1)
	gpsSensor.running=False #kill thread
	gpsSensor.join() #wait untill thread finish process
	print "Finish"
    
	#, GpsData.fix.longitude, GpsData.fix.altitude, GpsData.fix.speed,GpsData.fix.track, GpsData.fix.mode

'''
'''

	
	GpsThread=GpsPoller()
	GpsThread.start()
	try:
		print GpsData.fix.latitude, GpsData.fix.longitude, GpsData.fix.altitude, GpsData.fix.speed,GpsData.fix.track, GpsData.fix.mode
			
	except (KeyboardInterrupt, SystemExit): #when you press ctrl+c
		print "\nKilling Thread..."
		GpsThread.running = False
		GpsThread.join() # wait for the thread to finish what it's doing

      print 'latitude    ' , GpsData.fix.latitude
      print 'longitude   ' , GpsData.fix.longitude
      print 'time utc    ' , GpsData.utc,' + ', GpsData.fix.time
      print 'altitude (m)' , GpsData.fix.altitude
      print 'eps         ' , GpsData.fix.eps
      print 'epx         ' , GpsData.fix.epx
      print 'epv         ' , GpsData.fix.epv
      print 'ept         ' , GpsData.fix.ept
      print 'speed (m/s) ' , GpsData.fix.speed
      print 'climb       ' , GpsData.fix.climb
      print 'track       ' , GpsData.fix.track
      print 'mode        ' , GpsData.fix.mode
      print
      print 'sats        ' , GpsData.satellites
'''
