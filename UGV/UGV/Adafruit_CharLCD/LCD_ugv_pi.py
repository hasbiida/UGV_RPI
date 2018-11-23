#!/usr/bin/python

from Adafruit_CharLCD import Adafruit_CharLCD
from subprocess import * 
from time import sleep, strftime
from datetime import datetime

lcd = Adafruit_CharLCD()

cmd = "ip addr show eth0 | grep inet | awk '{print $2}' | cut -d/ -f1"
cmd2 = "ip addr show wlan0 | grep inet | awk '{print $2}' | cut -d/ -f1"

lcd.begin(16,1)

def run_cmd(cmd):
        p = Popen(cmd, shell=True, stdout=PIPE)
        output = p.communicate()[0]
        return output
def run_cmd2(cmd2):
	p = Popen(cmd2, shell=True, stdout=PIPE)
	output = p.communicate()[0]
	return output

while 1:
	lcd.clear()
	ipaddr = run_cmd(cmd)
	lcd.message(datetime.now().strftime('%b %d  %H:%M:%S\n'))
	lcd.message('et %s' % ( ipaddr ) )
	sleep(2)
	lcd.clear()
        ipaddr2 = run_cmd2(cmd2)
        lcd.message(datetime.now().strftime('%b %d  %H:%M:%S\n'))
        lcd.message('wl %s' % ( ipaddr2 ) )
        sleep(2)

