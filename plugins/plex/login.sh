if [[ -f "/root/.local/share/Plexamp/Settings/%40Plexamp%3Auser%3Atoken" ]]; then
    echo "Plexamp appears to be already configured, skipping..."
    exit 1
fi

echo "When prompted, enter your claim token from https://plex.tv/claim"
echo "Plexamp should exit after entering your claim token and player name, if it doesnt press control+c. After exiting, you can restart this container and exit the terminal."

cd /opt/plexamp/plexamp/

node js/index.js