
#/bin/bash
echo "kill gps instance"
sudo killall gpsd
sleep 0.5
sudo rm /var/run/gpsd.sock
sleep 0.5

echo "start gps service"
sudo gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock

#echo "reset performed on $(date)" >> reset.log
