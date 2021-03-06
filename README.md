![](docs/mona.gif)

# Avatarify

Photorealistic avatars for Skype and Zoom. Democratized.

Based on [First Order Motion Model](https://github.com/AliaksandrSiarohin/first-order-model).

Created by: [Ali Aliev](https://github.com/alievk) and [Karim Iskakov](https://github.com/karfly).

**Disclaimer**: This project is unrelated to Samsung AI Center.

## Requirements

To run Avatarify smoothly you need a CUDA-enabled (NVIDIA) video card. Otherwise it will fallback to the central processor and run very slowly. These are performance metrics for some hardware:

- GeForce GTX 1080 Ti: **33 fps**
- GeForce GTX 1070: **15 fps**
- Mac OSX (MacBook Pro 2018; no GPU): **very slow** **~1 fps**

Of course, you also need a webcam!

<!-- * [conda Python 3.7](https://docs.conda.io/en/latest/miniconda.html)
* [CUDA](https://developer.nvidia.com/cuda-downloads) -->

## Install

#### Download network weights
Download model's weights from [Dropbox](https://www.dropbox.com/s/c2mya1j07ittax6/vox-adv-cpk.pth.tar?dl=0), [Mega](https://mega.nz/file/R8kxQKLD#036S-bobZ9IW-kNNcSlgpfJWBKSi5nkhouCYAsxz3qI), [Yandex.Disk](https://yadi.sk/d/lEw8uRm140L_eQ/vox-adv-cpk.pth.tar) or [Google Drive](https://drive.google.com/file/d/1L8P-hpBhZi8Q_1vP2KlQ4N6dvlzpYBvZ/view) [716 MB, md5sum `46b26eabacbcf1533ac66dc5cf234c5e`]


#### Mac
*(!) Note*: we found out that in versions after [v4.6.8 (March 23, 2020)](https://zoom.us/client/4.6.19178.0323/ZoomInstaller.pkg) Zoom disabled support for virtual cameras on Mac. To use Avatarify in Zoom you can choose from 2 options:
- Install [Zoom v4.6.8](https://zoom.us/client/4.6.19178.0323/ZoomInstaller.pkg) which is the last version that supports virtual cameras
- Use latest version of Zoom, but disable library validation:
```bash
codesign --remove-signature /Applications/zoom.us.app
```

For Mac it's quite difficult to create a virtual camera, so we'll use [CamTwist](http://camtwiststudio.com) app.

1. Install [Miniconda Python 3.7](https://docs.conda.io/en/latest/miniconda.html#macosx-installers) or use *Homebrew Cask*: `brew cask install miniconda`.
2. Clone `avatarify` and install its dependencies:
```bash
git clone https://github.com/alievk/avatarify.git
cd avatarify
bash scripts/install_mac.sh
```
3. [Download network weights](#download-network-weights) and place `vox-adv-cpk.pth.tar` file in the `avatarify` directory (don't unpack it).
4. Download and install [CamTwist](http://camtwiststudio.com) from [here](http://camtwiststudio.com/download). It's easy.



## Setup avatars
Avatarify comes with a standard set of avatars of famous people, but you can extend this set simply copying your avatars into `avatars` folder.

Follow these advices for better visual quality:
* Make square crop of your avatar picture.
* Crop avatar's face so that it's not too close not too far. Use standard avarars as reference.
* Prefer pictures with uniform background. It will diminish visual artifacts.

## Run
Your web cam must be plugged-in.

**Note:** run Skype or Zoom only after Avatarify is started.


#### Mac
1. Run:
```bash
bash run_mac.sh
```
2. Go to [CamTwist](http://camtwiststudio.com).
3. Choose `Desktop+` and press `Select`.
4. In the `Settings` section choose `Confine to Application Window` and select `python (avatarify)` from the drop-down menu.

`cam` and `avatarify` windows will pop-up. The `cam` window is for controlling your face position and `avatarify` is for the avatar animation preview. Please follow these [recommendations](#driving-your-avatar) to drive your avatars.


## Controls


Keys | Controls
--- | ---
1-9 | These will immediately switch between the first 9 avatars.
Q | Turns on StyleGAN-generated avatar. Every time you push the button – new avatar is sampled.
0 | Toggles avatar display on and off.
A/D | Previous/next avatar in folder.
W/S | Zoom camera in/out.
Z/C | Adjust avatar target overlay opacity.
X | Reset reference frame.
F | Toggle reference frame search mode.
R | Mirror reference window.
T | Mirror output window.
I | Show FPS
ESC | Quit

## Driving your avatar

These are the main principles for driving your avatar:

* Align your face in the camera window as closely as possible in proportion and position to the target avatar. Use zoom in/out function (W/S keys). When you have aligned, hit 'X' to use this frame as reference to drive the rest of the animation
* Use the overlay function (Z/C keys) to match your and avatar's face expressions as close as possible

Alternatively, you can hit 'F' for the software to attempt to find a better reference frame itself. This will slow down the framerate, but while this is happening, you can keep moving your head around: the preview window will flash green when it finds your facial pose is a closer match to the avatar than the one it is currently using. You will see two numbers displayed as well: the first number is how closely you are currently aligned to the avatar, and the second number is how closely the reference frame is aligned.

You want to get the first number as small as possible - around 10 is usually a good alignment. When you are done, press 'F' again to exit reference frame search mode.

You don't need to be exact, and some other configurations can yield better results still, but it's usually a good starting point.

## Configure video meeting app

### Skype

Go to Settings -> Audio & Video, choose `avatarify` (Linux), `CamTwist` (Mac) or `OBS-Camera` (Windows) camera.

<img src=docs/skype.jpg width=600>

### Zoom

Go to Settings -> Video and choose `avatarify` (Linux), `CamTwist` (Mac) or `OBS-Camera` (Windows) from Camera drop-down menu.

<img src=docs/zoom.jpg width=600>

### Slack

Make a call, allow browser using cameras, click on Settings icon, choose `avatarify` (Linux), `CamTwist` (Mac) or `OBS-Camera` (Windows) in Video settings drop-down menu.

<img src=docs/slack.jpg width=600>


## Contribution

Our goal is to democratize deepfake avatars. To make the technology even more accessible, we have to tackle two major problems:

1. Add support for more platforms (Linux and Mac are already supported).
2. Optimize neural network run-time. Running network real-time on CPU is of high priority.

Please make pull requests if you have any improvements or bug-fixes.


## Troubleshooting

* *My avatar is distorted*: Please follow these [recommendation](#driving-your-avatar) for avatar driving.
* *Zoom/Skype doesn't see `avatarify` camera*. Restart Zoom/Skype and try again.
* *Avatar image is frozen*: In Zoom, try Stop and Start Video.
* *`bash run_mac.sh` crashes with "Cannot open camera"*: Try to change CAMID in `run_mac.sh` from `0` to `1`, `2`, ...
* `pipe:0: Invalid data found when processing input`: Make sure `CAMID` in `scripts/settings.sh` is correct. Use `v4l2-ctl --list-devices` to query available devices.
* `ASSERT: "false" in file qasciikey.cpp, line 501`. If you have several keyboard layouts, switch to English layout.
* `No such file or directory: 'vox-adv-cpk.pth.tar'`. Please follow instructions [Download network weights](#download-network-weights)
