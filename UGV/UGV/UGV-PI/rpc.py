
#use for RPC communication to control station
from Controler import Controler
from SensorMagnetometer import MagnetometerHMC
import xmlrpclib
import SimpleXMLRPCServer
import string,socket
import time

left=1
right=1
accessList=('10.10.1.41','10.14.1.3')

class Server(SimpleXMLRPCServer.SimpleXMLRPCServer):
    def __init__(self,*args):
        SimpleXMLRPCServer.SimpleXMLRPCServer.__init__(self,(args[0],args[1]))
        
    def server_bind(self):
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        SimpleXMLRPCServer.SimpleXMLRPCServer.server_bind(self)

    def verify_request(self,request, client_address):
        if client_address[0] in accessList:
            return 1
        else:
			return 0
class learningdata:
	def __init__(self):
		pass
	def manual(self,pwml,pwmr,left,right):
		Con=Controler(mode="manual")
		dataSerial=Con.manual(pwml,pwmr,left,right)
		self.Magnetometer=MagnetometerHMC()
		(MagnetometerHeading,MagnetometerMinute)=self.Magnetometer.data()
		return time.strftime("%Y:%m:%d:%H:%M:%S", time.gmtime()),MagnetometerHeading,dataSerial[1],dataSerial[2]
if __name__ == "__main__":
	server = Server('',8000)
	print "Listen port 8000"
	server.register_instance(learningdata())
	server.serve_forever()
