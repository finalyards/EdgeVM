# Setting up usbipd

USB/IP provides a way to turn USB traffic over to IP - and back. This is needed for passing-through a devkit from your (macOS) host to a Lima VM.


## Installing (macOS)

Go to [`usbipd-mac`](https://github.com/beriberikix/usbipd-mac) (GitHub) > `Releases` > 0.6.0 (or later).

>If you use Homebrew, you can follow those instructions. This repo follows the manual path.

- **DO NOT** follow the online instructions (0.6.0); they are aged.

	The 0.6.0 no longer needs the system extension (this is explained in the main README). You can bind devices not recognized by macOS itself with just a binary.

- Download [`usbipd-v0.6.0-macos-arm64`](https://github.com/beriberikix/usbipd-mac/releases/download/v0.6.0/usbipd-v0.6.0-macos-arm64) (or the `x86_64` variant for Intel Macs).

- Unquarantine the file (if you trust it!):

	```
	% xattr -d com.apple.quarantine usbipd-v0.6.0-macos-arm64
	```

- You might want to shorten the name - the OS and variant parts are not really needed:

	```
	% mv usbipd-v0.6.0-macos-arm64 usbipd-v0.6.0
	```

- Make it executable:

	```
	% chmod +x usbipd-v0.6.0
	```

- Move the file to a suitable location, e.g. `~/bin` (expected to be within your `PATH`).

	Either rename it to `usbipd` or use a symbolic link:
	
	```
	% mv usbipd-v0.6.0 ~/bin
	% cd ~/bin
	% ln -s usbipd-0.6.0 usbipd
	```

- Test:

	```
	% cd 
	```
	```
	% usbipd --version
	USB/IP Daemon for macOS
	Version: 0.6.0
	Build: release
	```

## Installing (Windows)

Have a look at: [`usbipd-win`](https://github.com/dorssel/usbipd-win).

<!-- #later???
## Installing (Linux)

*please contribute?*
-->


## Binding

Connect the devkit with a USB cable to the host.

```
% usbipd list  
Local USB Device(s)
==================
Busid  Dev-Node                                    USB Device Information
------------------------------------------------------------------------------------
0-1         /dev/bus/usb/0/1                05ac:0250 (Keychron K3)
1-1         /dev/bus/usb/1/1                10c4:ea60 (CP2102N USB to UART Bridge Controller)
```

>Notice the `10c4:ea60`. These are USB identifiers depending on the port you attached the cable to. You'll see them in the VM section.

The device is connected in the host port `1-1` (your port may be different).

```
% usbipd bind 1-1
...
Bound device 1-1: 10c4:ea60 (CP2102N USB to UART Bridge Controller)
Registered for USB/IP sharing. No driver or process holds this device.
```

## Starting the service (macOS)

The `usbipd` macOS version is mainly intended to be used under Homebrew. There, service activation is part of the [official instructions](https://github.com/beriberikix/usbipd-mac#homebrew-installation-recommended).

If you have opted for a manual install, the story is more complicated.

Options:

- launch in a dedicated terminal, as a foreground process
- launch as a background process
- install as a system wide service

We don't go through all of these. Just giving some guidence that you can get things running, VM side.

### Foreground process

- Open a new terminal window

```
% usbipd daemon --foreground
...
USB/IP daemon started on port 3240
Running in foreground mode. Press Ctrl+C to stop.
Note: In the MVP, the server will run until the process is terminated.
In a full implementation, the server would handle signals properly.
USB/IP daemon running in foreground. Press Ctrl+C to stop.
...
```

>Note: There are quite many `[INFO]` level log lines. Just ignore them. The author has not found a mechanism in 0.6.0 to steer the logging level. <!-- tbd. report upstream? -->

**This is the mode the author prefers.** He runs it after having connected the devkit by USB cable.


### Background process

```
% sudo usbipd daemon
...
USB/IP daemon started on port 3240
Running in background mode.
USB/IP daemon started in background mode.
...
```

All good here. The process does not release the terminal, so the mode feels quite the same as the "foreground" mode is.

>Hint: You may:
>
>- Ctrl-Z
>- `bg`
>- `disown`

Now the process runs detached of your terminal. You can see it with:

```
% ps aux | grep usbipd
```

After a restart, you'll **need to repeat the steps**, since the process is not getting automatically served.

### Proper service

I'm not entering this because a) I'd not use it myself, b) you'd likely use `brew` anyways, c) it's complicated and involves system-wide changes (`/Library/LaunchDaemons`).

*tbd. Should we describe it?*

<!--
### Hints (macOS)

To see whether `usbipd` is already running:

```
% ps aux | grep usbipd
```

To kill a service, `kill {pid}`.
-->


## Credits

<font size=+4>👏</font> for `beriberikix` for porting USB/IP to the macOS! 
