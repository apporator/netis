#!/bin/sh

OP_MODE=`flash get OP_MODE`
eval `flash get WAN_DHCP`
if [ "$OP_MODE" = "OP_MODE=0" -o "$OP_MODE" = "OP_MODE=1" ];then
	if [ "$OP_MODE" = "OP_MODE=0" ]; then
		multi_ppp eth1
	fi
	exit 0
fi

if [ $WAN_DHCP != "3" ]; then
	echo "Not PPPoE Connection, $0 exit."
	exit 0
fi

if [ "$OP_MODE" = "OP_MODE=2" -o "$OP_MODE" = "OP_MODE=3" ]; then
	echo "----------------client_pppoe.sh wisp ------------"
	PID=`cat /var/run/multippp.pid`
	kill -9 "$PID"
	if [ $OP_MODE = "OP_MODE=2" ];then
		WLAN_IFACE=wlan1
		brctl delif br0 $WLAN_IFACE
		sleep 5
	else
		WLAN_IFACE=wlan0
		brctl addif br0 $WLAN_IFACE
		ifconfig $WLAN_IFACE down
		ifconfig $WLAN_IFACE up
		sleep 5
		brctl delif br0 $WLAN_IFACE
		sleep 3
	fi
	multi_ppp $WLAN_IFACE
fi
