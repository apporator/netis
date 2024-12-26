#!/bin/sh
if [ $1 = "start" ]; then
	#statements
	/bin/usb_led &
fi

if [ $1 = "stop" ]; then
	#statements
	killall usb_led
	rm /var/usb_led.pid
fi

if [ $1 = "blink" ]; then
	#statements
	killall -16 usb_led
fi

if [ $1 = "on" ]; then
	killall -17 usb_led
fi
