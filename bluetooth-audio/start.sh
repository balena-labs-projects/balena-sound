#!/usr/bin/env bash

if [[ -z "$BLUETOOTH_DEVICE_NAME" ]]; then
  BLUETOOTH_DEVICE_NAME=$(printf "balenaSound %s" $(hostname | cut -c -4))
fi

# Set the system volume here
SYSTEM_OUTPUT_VOLUME="${SYSTEM_OUTPUT_VOLUME:-100}"
echo $SYSTEM_OUTPUT_VOLUME > /usr/src/system_output_volume
printf "Setting output volume to %s%%\n" "$SYSTEM_OUTPUT_VOLUME"
amixer sset PCM,0 $SYSTEM_OUTPUT_VOLUME% > /dev/null &

# Set the volume of the connection notification sounds here
CONNECTION_NOTIFY_VOLUME="${CONNECTION_NOTIFY_VOLUME:-75}"
echo $CONNECTION_NOTIFY_VOLUME > /usr/src/connection_notify_volume
printf "Connection notify volume is %s%%\n" "$CONNECTION_NOTIFY_VOLUME"

# Set the discoverable timeout here
dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0 org.freedesktop.DBus.Properties.Set string:'org.bluez.Adapter1' string:'DiscoverableTimeout' variant:uint32:0 > /dev/null

printf "Restarting bluetooth service\n"
service bluetooth restart > /dev/null
sleep 2

# Redirect stdout to null, because it prints the old BT device name, which
# can be confusing and it also hides those commands from the logs as well.
printf "discoverable on\npairable on\nexit\n" | bluetoothctl > /dev/null

hciconfig hci0 sspmode 0

if [ -z "$(lsusb | grep -i bluetooth)" -a -z "$BLUETOOTH_PIN_CODE" ]; then
bt-agent -c NoInputNoOutput &
else
if [ "$(echo -n "$BLUETOOTH_PIN_CODE" | wc -m)" -gt 16 ]; then
printf "%s\n" "You used more than 16 characters. Resetting to 0000. "
BLUETOOTH_PIN_CODE=0000
fi
echo "* ${BLUETOOTH_PIN_CODE:-0000}" > /usr/src/bluetooth.cfg
chmod -v o-r /usr/src/bluetooth.cfg >/dev/null
bt-agent -p /usr/src/bluetooth.cfg &
fi

sleep 2
rm -rf /var/run/bluealsa/
/usr/bin/bluealsa -i hci0 -p a2dp-sink &

hciconfig hci0 up
hciconfig hci0 name "$BLUETOOTH_DEVICE_NAME"

sleep 2
printf "Device is discoverable as \"%s\"\n" "$BLUETOOTH_DEVICE_NAME"
/usr/bin/bluealsa-aplay --pcm-buffer-time=1000000 00:00:00:00:00:00
