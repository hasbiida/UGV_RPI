import serial
import io

s = serial.Serial('/dev/ttyAMA0',9600)
ls=[]
if __name__=='__main__':
	print "input pwml?"
	pwml=raw_input()
	pwmr=raw_input()
	left=1
	right=0
	datas="$master,%s,%s,%i,%i\r\n" % (pwml,pwmr,left,right)
	print datas
	s.write(datas)
	s.flushInput()
	#s.flushOutput()
	for i in range(3):
		print "kirim %i" %(i)
		serdata = s.readline()
		ls.append(serdata)
		print serdata
	print ls
	serdata=[]
	s.close()
"""	print datas
	ser.write(unicode(datas))
	#line=[] #empty list
	data=ser.readline()
	print data
	#print unicode(line)
	ser.close()
"""



#format data master:pwml,pwmr,left,right\r\n 
#format data slave:pwml,pwmr,left,right\r\n 
#format data counter:counterl,counterr
