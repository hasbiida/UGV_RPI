#fuzzy code mf
#learning from http://www.codeproject.com/Articles/23387/Introduction-to-C-and-Fuzzy-Logic

class fuzzyUGVkiri:
	def __init__(self):
		#3 membership function input angle is -1800 to 1800
		#membership function lastangle range -215 - 137
		self.lastanglemf1=[-214.99,-126.98,-38.84]
		self.lastanglemf2=[-127.01,-38.69,48.99]
		self.lastanglemf3=[-39.31,49.29,137.00]
		#membership function angle
		self.anglemf1=[-214.99,-126.93,-38.60]
		self.anglemf2=[-127.07,-39.14,49.21]
		self.anglemf3=[-39.57,48.79,136.99]
		#output membership function
		self.mfout=[255.85,247.47,172.54,257.18,253.06,218.05,257.20,235.52,203.70]
		self.ffin1=[]
		self.ffin2=[]
		self.inf=[]
	def fuzzyfication(self):
		self.ffin1=[0,0,0]#reset last error
		self.ffin2=[0,0,0]#reset error
		#fuzzification for last error
		self.ffin1[0]=float(self.trishape(self.lastangle,self.lastanglemf1[0],self.lastanglemf1[1],self.lastanglemf1[2]))
		self.ffin1[1]=float(self.trishape(self.lastangle,self.lastanglemf2[0],self.lastanglemf2[1],self.lastanglemf2[2]))
		self.ffin1[2]=float(self.trishape(self.lastangle,self.lastanglemf3[0],self.lastanglemf3[1],self.lastanglemf3[2]))
		#fuzzification for error
		self.ffin2[0]=float(self.trishape(self.angle,self.anglemf1[0],self.anglemf1[1],self.anglemf1[2]))
		self.ffin2[1]=float(self.trishape(self.angle,self.anglemf2[0],self.anglemf2[1],self.anglemf2[2]))
		self.ffin2[2]=float(self.trishape(self.angle,self.anglemf3[0],self.anglemf3[1],self.anglemf3[2]))
		print self.ffin1,self.ffin2
	def trishape(self,x,a,b,c):
		#triangle function
		triout=0
		self.triout=float(triout)
		if x>a and x<=b:
			self.triout=float(x-a)/float(b-a)
		elif x>b and x<=c:
			self.triout=float(-(x-c))/float(c-b)
		elif x<=a or x>=c:
			self.triout=float(0)
		#print self.triout, type(self.triout)
		return self.triout
	def inference(self):
		#get from rule anfis use sugeno singleton mf
		"""
		generate using matlab anfis gui has 9 rule
		"""
		self.inf=[0,0,0,0,0,0,0,0,0] #
		#1. (input1==in1mf1) & (input2==in2mf1) => (output=out1mf1) (1)
		if self.ffin1[0]<>0 and self.ffin2[0]<>0:
			#self.inf[0]=self.ffin1[0]+self.ffin2[0]-(self.ffin1[0]*self.ffin2[0])
			self.inf[0]=(self.ffin1[0]*self.ffin2[0])
		#2. (input1==in1mf1) & (input2==in2mf2) => (output=out1mf2) (1)
		if self.ffin1[0]<>0 and self.ffin2[1]<>0:
			#self.inf[1]=self.ffin1[0]+self.ffin2[1]-(self.ffin1[0]*self.ffin2[1])
			self.inf[1]=(self.ffin1[0]*self.ffin2[1])
		#3. (input1==in1mf1) & (input2==in2mf3) => (output=out1mf3) (1)
		if self.ffin1[0]<>0 and self.ffin2[2]<>0:
			#self.inf[2]=self.ffin1[0]+self.ffin2[2]-(self.ffin1[0]*self.ffin2[2])
			self.inf[2]=(self.ffin1[0]*self.ffin2[2])
		#4. (input1==in1mf2) & (input2==in2mf1) => (output=out1mf4) (1)
		if self.ffin1[1]<>0 and self.ffin2[0]<>0:
			#self.inf[3]=self.ffin1[1]+self.ffin2[0]-(self.ffin1[1]*self.ffin2[0])
			self.inf[3]=(self.ffin1[1]*self.ffin2[0])
		#5. (input1==in1mf2) & (input2==in2mf2) => (output=out1mf5) (1)
		if self.ffin1[1]<>0 and self.ffin2[1]<>0:
			#self.inf[4]=self.ffin1[1]+self.ffin2[1]-(self.ffin1[1]*self.ffin2[1])
			self.inf[4]=(self.ffin1[1]*self.ffin2[1])
		#6. (input1==in1mf2) & (input2==in2mf3) => (output=out1mf6) (1)
		if self.ffin1[1]<>0 and self.ffin2[2]<>0:
			#self.inf[5]=self.ffin1[1]+self.ffin2[2]-(self.ffin1[1]*self.ffin2[2])
			self.inf[5]=(self.ffin1[1]*self.ffin2[2])
		#7. (input1==in1mf3) & (input2==in2mf1) => (output=out1mf7) (1)
		if self.ffin1[2]<>0 and self.ffin2[0]<>0:
			#self.inf[6]=self.ffin1[2]+self.ffin2[0]-(self.ffin1[2]*self.ffin2[0])
			self.inf[6]=(self.ffin1[2]*self.ffin2[0])
		#8. (input1==in1mf3) & (input2==in2mf2) => (output=out1mf8) (1)
		if self.ffin1[2]<>0 and self.ffin2[1]<>0:
			#self.inf[7]=self.ffin1[2]+self.ffin2[1]-(self.ffin1[2]*self.ffin2[1])
			self.inf[7]=(self.ffin1[2]*self.ffin2[1])
		#9. (input1==in1mf3) & (input2==in2mf3) => (output=out1mf9) (1)
		if self.ffin1[2]<>0 and self.ffin2[2]<>0:
			#self.inf[8]=self.ffin1[2]+self.ffin2[2]-(self.ffin1[2]*self.ffin2[2])
			self.inf[8]=(self.ffin1[2]*self.ffin2[2])
	def defuzzy(self):
		#use sugeno model weight average defuzzyfication singleton 
		self.defuz=float(0)
		#print self.angle,self.inf,sum(self.inf)
		i=0
		upper=float(0)
		for i in range(len(self.inf)):
			upper+=(float(self.inf[i])*self.mfout[i])
			print self.inf[i],self.mfout[i]
		self.defuz=upper/ sum(self.inf)
	def GetResult(self,angle,lastangle):
		self.angle=angle
		self.lastangle=lastangle
		self.fuzzyfication()
		self.inference()
		self.defuzzy()
		return self.defuz
		
class fuzzyUGVkanan:
	def __init__(self):
		#3 membership function input angle is -1800 to 1800
		#membership function lastangle range -215 - 137
		self.lastanglemf1=[-215,-127.98,-39.00]
		self.lastanglemf2=[-126.91,-38.76,48.99]
		self.lastanglemf3=[-39.44,49.25,137]
		#membership function angle
		self.anglemf1=[-214.99,-126.91,-38.82]
		self.anglemf2=[-127.09,-39.11,49.20]
		self.anglemf3=[-39.62,48.79,136.99]
		#output membership function
		self.mfout=[137.93,219.94,253.07,173.51,194.65,232.27,190.85,214.71,244.54]
		self.ffin1=[]
		self.ffin2=[]
		self.inf=[]
	def fuzzyfication(self):
		self.ffin1=[0,0,0]#reset last error
		self.ffin2=[0,0,0]#reset error
		#fuzzification for last error
		self.ffin1[0]=float(self.trishape(self.lastangle,self.lastanglemf1[0],self.lastanglemf1[1],self.lastanglemf1[2]))
		self.ffin1[1]=float(self.trishape(self.lastangle,self.lastanglemf2[0],self.lastanglemf2[1],self.lastanglemf2[2]))
		self.ffin1[2]=float(self.trishape(self.lastangle,self.lastanglemf3[0],self.lastanglemf3[1],self.lastanglemf3[2]))
		#fuzzification for error
		self.ffin2[0]=float(self.trishape(self.angle,self.anglemf1[0],self.anglemf1[1],self.anglemf1[2]))
		self.ffin2[1]=float(self.trishape(self.angle,self.anglemf2[0],self.anglemf2[1],self.anglemf2[2]))
		self.ffin2[2]=float(self.trishape(self.angle,self.anglemf3[0],self.anglemf3[1],self.anglemf3[2]))
		print self.ffin1,self.ffin2
	def trishape(self,x,a,b,c):
		#triangle function
		triout=0
		self.triout=float(triout)
		if x>a and x<=b:
			self.triout=float(x-a)/float(b-a)
		elif x>b and x<=c:
			self.triout=float(-(x-c))/float(c-b)
		elif x<=a or x>=c:
			self.triout=float(0)
		#print self.triout, type(self.triout)
		return self.triout
	def inference(self):
		#get from rule anfis use sugeno singleton mf
		"""
		generate using matlab anfis gui has 9 rule
		"""
		self.inf=[0,0,0,0,0,0,0,0,0] #
		#1. (input1==in1mf1) & (input2==in2mf1) => (output=out1mf1) (1)
		if self.ffin1[0]<>0 and self.ffin2[0]<>0:
			#self.inf[0]=self.ffin1[0]+self.ffin2[0]-(self.ffin1[0]*self.ffin2[0])
			self.inf[0]=(self.ffin1[0]*self.ffin2[0])
		#2. (input1==in1mf1) & (input2==in2mf2) => (output=out1mf2) (1)
		if self.ffin1[0]<>0 and self.ffin2[1]<>0:
			#self.inf[1]=self.ffin1[0]+self.ffin2[1]-(self.ffin1[0]*self.ffin2[1])
			self.inf[1]=(self.ffin1[0]*self.ffin2[1])
		#3. (input1==in1mf1) & (input2==in2mf3) => (output=out1mf3) (1)
		if self.ffin1[0]<>0 and self.ffin2[2]<>0:
			#self.inf[2]=self.ffin1[0]+self.ffin2[2]-(self.ffin1[0]*self.ffin2[2])
			self.inf[2]=(self.ffin1[0]*self.ffin2[2])
		#4. (input1==in1mf2) & (input2==in2mf1) => (output=out1mf4) (1)
		if self.ffin1[1]<>0 and self.ffin2[0]<>0:
			#self.inf[3]=self.ffin1[1]+self.ffin2[0]-(self.ffin1[1]*self.ffin2[0])
			self.inf[3]=(self.ffin1[1]*self.ffin2[0])
		#5. (input1==in1mf2) & (input2==in2mf2) => (output=out1mf5) (1)
		if self.ffin1[1]<>0 and self.ffin2[1]<>0:
			#self.inf[4]=self.ffin1[1]+self.ffin2[1]-(self.ffin1[1]*self.ffin2[1])
			self.inf[4]=(self.ffin1[1]*self.ffin2[1])
		#6. (input1==in1mf2) & (input2==in2mf3) => (output=out1mf6) (1)
		if self.ffin1[1]<>0 and self.ffin2[2]<>0:
			#self.inf[5]=self.ffin1[1]+self.ffin2[2]-(self.ffin1[1]*self.ffin2[2])
			self.inf[5]=(self.ffin1[1]*self.ffin2[2])
		#7. (input1==in1mf3) & (input2==in2mf1) => (output=out1mf7) (1)
		if self.ffin1[2]<>0 and self.ffin2[0]<>0:
			#self.inf[6]=self.ffin1[2]+self.ffin2[0]-(self.ffin1[2]*self.ffin2[0])
			self.inf[6]=(self.ffin1[2]*self.ffin2[0])
		#8. (input1==in1mf3) & (input2==in2mf2) => (output=out1mf8) (1)
		if self.ffin1[2]<>0 and self.ffin2[1]<>0:
			#self.inf[7]=self.ffin1[2]+self.ffin2[1]-(self.ffin1[2]*self.ffin2[1])
			self.inf[7]=(self.ffin1[2]*self.ffin2[1])
		#9. (input1==in1mf3) & (input2==in2mf3) => (output=out1mf9) (1)
		if self.ffin1[2]<>0 and self.ffin2[2]<>0:
			#self.inf[8]=self.ffin1[2]+self.ffin2[2]-(self.ffin1[2]*self.ffin2[2])
			self.inf[8]=(self.ffin1[2]*self.ffin2[2])
	def defuzzy(self):
		#use sugeno model weight average defuzzyfication singleton 
		self.defuz=float(0)
		#print self.angle,self.inf,sum(self.inf)
		i=0
		upper=float(0)
		for i in range(len(self.inf)):
			upper+=(float(self.inf[i])*self.mfout[i])
			print self.inf[i],self.mfout[i]
		self.defuz=upper/ sum(self.inf)
	def GetResult(self,angle,lastangle):
		self.angle=angle
		self.lastangle=lastangle
		self.fuzzyfication()
		self.inference()
		self.defuzzy()
		return self.defuz
if __name__ == "__main__":
	fuz=fuzzyUGVkanan()
	print "error now"
	error=raw_input()
	print "last error"
	lasterror =raw_input()
	hasil=fuz.GetResult(int(error),int(lasterror))
	print hasil
