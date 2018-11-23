
#/bin/bash
sleep 2
echo "wlan0 down"
sudo ifconfig wlan0 down
sleep 3

sudo ifconfig wlan0 down;sudo iwconfig wlan0 mode ad-hoc
sleep 0.5

echo "set wlan0 as ad hoc"
sudo iwconfig wlan0 essid ugv-pi
sleep 0.5

echo "set wlan0 ip"
sudo ip addr add 10.14.1.1/24 dev wlan0
sleep 0.5

echo "wlan0 up"
sudo ifconfig wlan0 up
sleep 0.5

#tambahan
echo "kill gps instance"
sudo killall gpsd
sleep 0.5
sudo rm /var/run/gpsd.sock
sleep 0.5

echo "start gps service"
sudo gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock

#echo "reset performed on $(date)" >> reset.log
