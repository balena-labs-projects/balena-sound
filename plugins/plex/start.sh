#!/bin/bash

if [[ -n "$SOUND_DISABLE_PLEX" ]]; then
  echo "Plex is disabled, exiting..."
  exit 0
fi

if [[ ! -f "/root/.local/share/Plexamp/Settings/%40Plexamp%3Auser%3Atoken" ]]; then
    echo "__________________________________________WARNING__________________________________________________"
    echo "|                                  Plex is not configured!                                        |"
    echo "| Please enter a shell into the Plex container and run `bash login.sh` to setup your credentials! |"
    echo "|_________________________________________________________________________________________________|"
    echo ""
    echo "Note: This is likely to change as headless Plexamp versions are released with new features."
    echo "  Passing a claim token via a command line argument has been suggested, we will have to see."
    sleep 120
    exit 1
fi

echo "Starting Plex plugin..."

cd /opt/plexamp/plexamp/

node js/index.js
