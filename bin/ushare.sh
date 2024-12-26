#!/bin/sh

USHARE_CONF=/var/ushare.conf
eval `flash get USER_NAME`
eval `flash get DLNA_ENABLE`


if [ "$DLNA_ENABLE" = "0" ]; then
        #statements
        killall ushare
        exit 0
fi

rm $USHARE_CONF -f
echo "USHARE_NAME=netis">$USHARE_CONF
echo "USHARE_IFACE=br0">>$USHARE_CONF
echo "ENABLE_TELNET=yes">>$USHARE_CONF
echo "ENABLE_DLNA=yes">>$USHARE_CONF
echo "USHARE_ENABLED=1">>$USHARE_CONF
echo "ENABLE_XBOX=yes">>$USHARE_CONF
echo "ENABLE_WEB=no">>$USHARE_CONF
echo "USHARE_USERNAME="$USER_NAME>>$USHARE_CONF

PART1=""

for part in a b c d e f g h i j k l m n o p q r s t u v w x y z
do
        for index in 1 2 3 4 5 6 7 8 9
        do
                if [ -e "/var/sd$part$index" ];then
                        PART1="/var/sd$part$index"_dir
                        MOUNT_DISK=`cat /proc/mounts |grep "$PART1"`
                        if [ "$MOUNT_DISK" != "" ];then
                                break;
                        fi
                fi
        done
        if [ "$PART1" != "" ]; then
                break;
        fi
done


if [ "$PART1" = "" ]; then
        exit 0
else
	#statements
	/bin/ushare -f "$USHARE_CONF" -c "$PART1" -w 1>/dev/null &
fi
