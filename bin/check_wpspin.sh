#! /bin/sh

eval `flash get HW_WLAN0_WSC_PIN`
if [ "$HW_WLAN0_WSC_PIN" = "00000000" -o "$HW_WLAN0_WSC_PIN" = "" ] ; then
	/bin/wpspin.sh
fi

