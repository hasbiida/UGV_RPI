'''
autonomous use for autonoumous mode 
generate path planner and execute it use calss Navigation 
class autonomous bind in RPCserver
'''
import re

from Navigation import Navigation

class Autonomous.py
	def __init__(self,waypoint):
		self.waypoint=waypoint
		Nav=Navigation()
		self.wp=re.waypoint(",")
		self.pathplanning=[]
		
	def GeneratePathPlanning(self):
		self.sumwp=len.self.wp/2
		for n in sumwp: #
			self.pathplanning.append(self.wp[(n*2)]','self.wp[((n*2)+1)])
	def CurrentWp(self):
		#position
		if 
		self.cur_lat=self.Nav.gpsSensor.data[1]
		self.cur_long=self.Nav.gpsSensor.data[2]
		#orientation
		cur_heading=self.Magnetometer.data()
		return self.cur_lat,self.cur_long 
		
	def NextWp(self):
		
		
	def FinalWp(self):
		self.gpsSensor.running=False
		self.gpsSensor.join()	
		
	def WpData(self):
		return 
	
