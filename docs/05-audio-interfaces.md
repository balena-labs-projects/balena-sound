# Audio interfaces

If you want to upgrade the sound quality of your balenaSound devices, or if your board has no onboard soundcard, you'll probably want to add an external soundcard. Generally these come in two flavors: **USB soundcards** or **DAC boards**. Both alternatives are widely supported in balenaSound.

Checkout the [customization](customization#general) section to learn how to select which audio interface to use. For a detailed and up to date list of what interfaces are supported on each device check out the audio block [documentation](https://github.com/balenablocks/audio#supported-devices) section.

As a general rule of thumb, onboard and USB soundcards should work out of the box without any configuration, and DACs usually require setting a `dtoverlay`. Read on to learn more about the alternatives. If for any reason you can't get your soundcard to work, feel free to [contact us](./support#contact-us) and we'll gladly help out.

## Onboard

While most boards have built-in soundcards it's well known that the quality you can get from them is not the greatest. For the Raspberry Pi family for example, the Pi Foundation does an excellent job at keeping the cost of their boards down, but that comes with some compromises with audio being one of them. The [audio circuitry](https://hackaday.com/2018/07/13/behind-the-pin-how-the-raspberry-pi-gets-its-audio/) does an OK job, but it's nothing stellar. Onboard audiocards don't require any configuration.

## USB Soundcards

USB soundcards are also supported without any special configuration needed. Just make sure you power cycle your device after plugging in the soundcard and you should be good to go.

## DAC boards

### Overview

balenaSound supports a wide variety of DACs, but in an ever-growing market, chances are your particular DAC might not work with the project just yet. Broadly speaking, it's a two step process in order for a DAC to be officially supported:

1. the required kernel driver must be available in balenaOS
2. adequate testing must be performed with balenaSound

Latest versions of balenaOS already ships with drivers for most, if not all, of the DACs available. The testing story, however, is different. It's not possible for us to test all of them individually as it would take an incredible amount of resources. For this reason, we rely on community contributions to help catalogue existing DACs into three categories:

- [Supported DACs](#supported-dacs): battle-tested, known to work with balenaSound.
- [Untested DACs](#untested-dacs): DACs whose drivers are included in balenaOS but haven't been tested with balenaSound (most likely because no balena team member has one).
- [Unsupported DACs](#unsupported-dacs): DACs that probably need additional drivers that aren't currently available in balenaOS.

A curated list for all three categories can be found in the sections below. If you don't find your DAC anywhere, please add a comment to [this](https://github.com/balena-labs-projects/balena-sound/issues/439) GitHub issue and we'll take a look for you.

### Configuration

To get a DAC board to work with balenaSound you will need to enable its corresponding Device Tree Overlay. Thankfully balenaCloud makes this very easy to do.

In the balenaCloud dashboard:

- Click on the specific device within your fleet and select `Configuration` in the left-side menu.
- Add an additional custom configuration variable called `BALENA_HOST_CONFIG_dtoverlay`. The value of this will depend on your DAC board (see tables below in each DAC category subsection).
- Cycle the power by unplugging your device.

![DAC Configuration](https://raw.githubusercontent.com/balenalabs/balena-sound/master/docs/images/dac-vars.png)

If you're using multiple devices with multiple DACs for multi-room audio, you'll want to do this process per unique device that is using a DAC. Do not set this variable fleet-wide as it will affect every device within your fleet.

### Supported DACs

These are the DACs that are known to work with balenaSound. If you have trouble setting one up, please reach us at our [forums](https://forums.balena.io/) where we'll gladly help you troubleshoot the issue. Please **do not** create new GitHub issues for supported DACs unless you've been instructed to do so by our forums support agents.

| DAC Name                                     | BALENA_HOST_CONFIG_dtoverlay |
| -------------------------------------------- | ---------------------------- |
| [Suptronics X400][1]                         | iqaudio-dacplus              |
| [Pimoroni Pirate Audio][12]                  | hifiberry-dac                |
| [Pimoroni pHAT DAC][2]                       | hifiberry-dac                |
| [Justboom DAC HAT/Zero][3]                   | justboom-dac                 |
| [Justboom Amp HAT/Zero][30]                  | justboom-dac                 |
| [Justboom Digi HAT/Zero][25]                 | justboom-digi                |
| [Pisound][4]                                 | pisound                      |
| [InnoMaker HiFi DAC HAT][8]                  | allo-boss-dac-pcm512x-audio  |
| [InnoMaker HiFi Amp HAT][35]                 | hifiberry-amp                |
| [Boss DAC v1.2][29]                          | allo-boss-dac-pcm512x-audio  |
| [miniBoss DAC][10]                           | allo-boss-dac-pcm512x-audio  |
| [PiFi Digi+][11]                             | hifiberry-digi               |
| [IQaudIO Pi-DAC+][13]                        | iqaudio-dacplus              |
| [IQaudIO Pi-DAC Pro][31]                     | iqaudio-dacplus              |
| [IQaudIO Pi-DACZero][32]                     | iqaudio-dacplus              |
| [IQaudIO Pi-Digi+][33]                       | iqaudio-digi-wm8804-audio    |
| [IQaudIO Pi-DigiAMP+][34]                    | iqaudio-dacplus,unmute_amp   |
| [Hifiberry Amp2][14]                         | hifiberry-dacplus            |
| [Hifiberry DAC+][6]                          | hifiberry-dacplus            |
| [Hifiberry DAC+ Light][15]                   | hifiberry-dac                |
| [Hifiberry DAC+ Standard][16]                | hifiberry-dacplus            |
| [Hifiberry DAC+ Pro][17]                     | hifiberry-dacplus            |
| [Hifiberry DAC Zero][18]                     | hifiberry-dac                |
| [Hifiberry Amp+][19]                         | hifiberry-amp                |
| [Hifiberry Digi][20]                         | hifiberry-digi               |
| [Hifiberry Digi+][21]                        | hifiberry-digi               |
| [Hifiberry Beocreate][22]                    | hifiberry-dac                |
| [Hifiberry DAC+ DSP][23]                     | hifiberry-dac                |
| [Hifiberry MiniAmp][24]                      | hifiberry-dac                |
| [Hifiberry DAC2 HD][27]                      | hifiberry-dacplushd          |
| [Adafruit I2S Audio Bonnet][26]              | "hifiberry-dac","i2s-mmap"   |
| [Adafruit MAX98357 I2S Class-D Mono Amp][28] | "hifiberry-dac”,"i2s-mmap"   |
| [RasPiAudio Audio+ DAC][37]                  | hifiberry-dac                |
| [AUDIOPHONICS I-Sabre DAC ES9023][39]        | hifiberry-dac                |

[1]: http://www.suptronics.com/Xseries/x400.html
[2]: https://shop.pimoroni.com/products/phat-dac
[3]: https://uk.pi-supply.com/products/justboom-dac-hat
[4]: https://blokas.io/pisound/
[5]: https://forums.balena.io/t/regarding-dac-installation-on-balenasound-project/45568/27
[6]: https://www.hifiberry.com/products/dacplus/
[7]: https://forums.balena.io/t/no-sound-from-dac/61343/5
[8]: http://www.inno-maker.com/product/hifi-dac-hat/
[9]: https://github.com/balena-labs-projects/balena-sound/pull/98
[10]: https://allo.com/sparky/miniboss-rpi-zero.html
[11]: http://www.kumantech.com/kuman-sc07-raspberry-pi-hifi-digi-digital-sound-card-i2s-spdif-optical-fiber-for-raspberry-pi-3-2-model-b-b-sc07_p0041.html
[12]: https://shop.pimoroni.com/collections/pirate-audio
[13]: https://www.raspberrypi.org/products/iqaudio-dac-plus/
[14]: https://www.hifiberry.com/shop/boards/hifiberry-amp2/
[15]: https://www.hifiberry.com/shop/boards/hifiberry-dac-light/
[16]: https://www.hifiberry.com/shop/boards/hifiberry-dacplus-rca-version/
[17]: https://www.hifiberry.com/shop/boards/hifiberry-dac-pro/
[18]: https://www.hifiberry.com/shop/boards/hifiberry-dac-zero/
[19]: https://www.hifiberry.com/products/ampplus/
[20]: https://www.hifiberry.com/products/digi/
[21]: https://www.hifiberry.com/products/digiplus/
[22]: https://www.hifiberry.com/beocreate/
[23]: https://www.hifiberry.com/shop/boards/hifiberry-dac-dsp/
[24]: https://www.hifiberry.com/shop/boards/miniamp/
[25]: https://uk.pi-supply.com/products/justboom-digi-hat
[26]: https://www.adafruit.com/product/4037
[27]: https://www.hifiberry.com/shop/boards/hifiberry-dac2-hd/
[28]: https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp
[29]: https://allo.com/sparky/boss-dac.html
[30]: https://uk.pi-supply.com/products/justboom-amp-hat
[31]: https://www.raspberrypi.org/products/iqaudio-dac-pro/
[32]: http://www.thepilocator.com/Product/Info/iqaudio-pi-daczero-full-hd-audio-card-mmp
[33]: https://shop.pimoroni.com/products/pi-digi?variant=33370425994
[34]: https://www.raspberrypi.org/products/iqaudio-digiamp-plus/
[35]: https://www.inno-maker.com/product/hifi-amp-hat/
[36]: https://github.com/balena-labs-projects/balena-sound/issues/385
[37]: https://raspiaudio.com/produit/audio
[38]: https://github.com/balena-labs-projects/balena-sound/issues/355
[39]: https://www.audiophonics.fr/fr/dac-et-interfaces-pour-raspberry-pi/audiophonics-i-sabre-dac-es9023-tcxo-raspberry-pi-a-b-20-i2s-p-9978.html
[40]: https://github.com/balena-labs-projects/balena-sound/issues/345

### Untested DACs

An up to date list of untested DACs can be found in [this](https://github.com/balena-labs-projects/balena-sound/issues/439) GitHub issue. If you have one of these DACs and want to help us test it, please post on our [forums](https://forums.balena.io/) and we'll get back to you with instructions. Hopefully, with your assistance, new DACs can be graduated into the supported category!

**Note:** Please **do not** create new GitHub issues for untested DACs unless you've been instructed to do so by our forums support agents.

### Unsupported DACs

An up to date list of unsupported DACs can be found in [this](https://github.com/balena-labs-projects/balena-sound/issues/439) GitHub issue. Unsupported DACs can be made to work with balenaSound but often will require further investigation and patching balenaOS, so they are best avoided. Please **do** create a new GitHub issue if you are working on adding support or testing an unsupported DAC as that will facilitate discussion with balenaSound developers.
