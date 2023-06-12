# Plugins

Plugins are the sources from where you can stream audio to your device. balenaSound comes with a set of plugins installed by default and the possibility of adding some extra ones with a bit of tinkering. We are always on the lookout for adding new plugins so keep an eye out!

**Why not include all plugins by default?**
We want to avoid deploying all installable plugins by default because of (a) increased build time, (b) increased deploy time, (c) impact on device performance. Given that most users typically don't use more than one or two plugins it seems reasonable to limit defaults to the most popular ones to prevent users paying the cost of having many plugins that will never be used.

## Default

The following plugins ship with balenaSound out of the box:

- Spotify Connect
- Bluetooth
- AirPlay2
- Soundcard input (Requires setting `SOUND_ENABLE_SOUNDCARD_INPUT`, see [details](customization#plugins))

Default plugins can be disabled at runtime via variables. For more details see [here](customization#plugins).

### Spotify

Spotify Connect requires a premium account. There is two methods of authentication:

- zeroconf: most Spotify clients on smartphones, computers and smart tvs will automatically connect to balenaSound and pass on credentials without the need for manual authentication.
- manual: providing user and password via variables, see [customization](customization#plugins) section for details.

Manual authentication will let you stream audio over the internet from a client that is on a different network than the balenaSound device. This is useful if your balenaSound device is on a separate WiFi network that's harder to reach (e.g. a backyard network).

### Plexamp

The headless Plexamp plugin allows for casting to the fleet from the Plex(amp) mobile/desktop/web apps. A Plex Pass is required to use this plugin.

You need to log in before using this plugin, to do that, make sure the plugin has started and spawn a terminal into the container.
Once you have a terminal, run the following command:
```bash
bash login.sh
```
Plexamp will prompt you for a claim token from [plex.tv/claim](https://www.plex.tv/claim/) and a player name, this name is the name that will show in the Plex(amp) app.
Once you have logged in and set a player name, you can exit out of the terminal (you may need to press control+c if plex starts) and restart the Plexamp plugin.

## Installable

The following plugins are available to be added to your balenaSound installation:

- UPnP: Universal Plug and Play
- (Work in progress) Tidal Connect: See [PR #399](https://github.com/balena-labs-projects/balena-sound/pull/399)
- (Work in progress) Roon Bridge: See [PR #388](https://github.com/balena-labs-projects/balena-sound/pull/388)

Installing these plugins is a more involved process than just deploying the off the shelf version of balenaSound. You'll need to edit the contents of the `docker-compose.yml` file before deploying the app. This means that you won't be able to deploy using the "Deploy with balena" button; you either need to use the [CLI to deploy](https://balena-labs-projects.github.io/balena-sound/getting-started#cli-deploy) or use "Deploy with balena" with your own forked version of the project. If you don't feel comfortable performing these steps or need some help along the way hit us up at our [forums](https://forums.balena.io) and we'll gladly help you out.

### UPnP

To install UPnP plugin add the following to the `sevices` section on your `docker-compose.yml` file:

```
  upnp:
    build: ./plugins/upnp
    restart: on-failure
    network_mode: host
    ports:
      - 49494:49494
```
