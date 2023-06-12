version_info=$(curl https://plexamp.plex.tv/headless/version.json)

latest_version_number=$(echo $version_info | jq --raw-output '.latestVersion')
latest_version_url=$(echo $version_info | jq --raw-output '.updateUrl')

echo "Downloading PlexAmp version '$latest_version_number' from '$latest_version_url'"

wget "$latest_version_url" -O "plexamp.tar.bz2"

tar -xf plexamp.tar.bz2 


