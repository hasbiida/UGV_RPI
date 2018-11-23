'''
encoder mengolah data serial masukan menjadi data nilai encoder dan update nilai dengan menjumlahkan dengan nilai sebelumnya
'''
import re

class SensorEncoder:
	def __init__(self):
		self.dataserial=dataserial
		self.sumencoderL=0
		self.sumencoderR=0
	def update(self):
		self.sumencoderL+=int(self.encoderL)
		self.sumencoderR+=int(self.encoderR)
		return self.sumencoderL,self.sumencoderR
	def data(self,dataserial):
		enc=self.dataserial[2]
		#print enc
		listcount=re.split(",",enc)
		if listcount[0]=="$counter":
			self.encoderL=listcount[1]
			self.encoderR=listcount[2].strip() #bersihkan data menghilangkan komponen \r\n dibagian akhir
			return self.update()
	def status(self):
		pass
'''
if __name__=="__main__":
	dataserial=["$master,255,255,1,1","$slave,255,255","$counter,123,222"]
	Sen=SensorEncoder()
	data=Sen.data(dataserial)
	print data
	data=Sen.data(dataserial)
	print data
'''
