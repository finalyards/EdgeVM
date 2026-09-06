# Setting up usbipd (macOS)

USB/IP provides a way to turn USB traffic over to IP - and back. This is needed for passing-through a devkit from your host to a Lima VM.

>For a long time, macOS did not have an open source `usbipd` implementation. `beriberikix`'s [`usbipd-mac`](https://github.com/beriberikix/usbipd-mac) fills that void.
>
>However, it's still (Sep'26) in its infancy, and many features might be missing. The author keeps these instructions within the `DEVS` folder until the workflow is dependable.
>
>Consider it Beta.

<https://github.com/beriberikix/usbipd-mac>


## A. Installing (from Homebrew)

This is the easiest way. Follow the official instructions; they also cover managing the service.

>Note. The author avoids Homebrew. Thus the rest of the instructions deal with manual build and binary installation.


## A. Installing (from source)

Clone it.

```
% git clone https://github.com/beriberikix/usbipd-mac.git
```

Build it.

```
% cd usbipd-mac
% swift build
```

>You already had the necessary tools; they are part of Apple's Command Line Tools. XCode was not invoked.

Copy the created binary:

```
% cp .build/arm64-apple-macosx/debug/usbipd ~/bin
```

If you have `~/bin` on your `PATH`, you should now be able to:

```
% usbipd --version
USB/IP Daemon for macOS
Version: 0.6.0
Build: debug
```

>Note. The binary likely is other than "0.6.0", it just does not declare the git commit it represents. The `Build: debug` gives you a clue this was self-built.

Now, skip to [Binding](#Binding).


## B. Installing (from a release)

Go to `usbipd-mac` > [`Releases`](https://github.com/beriberikix/usbipd-mac/releases). Pick the last one...

- **DO NOT** follow the online instructions (0.6.0); they are aged.

	The 0.6.0 no longer needs the system extension (this is explained in the main `README` and `CHANGELOG`). You can bind devices not recognized by macOS itself with just a binary.

- Download [`usbipd-v0.6.0-macos-arm64`](https://github.com/beriberikix/usbipd-mac/releases/download/v0.6.0/usbipd-v0.6.0-macos-arm64) (or the `x86_64` variant for Intel Macs).

- Unquarantine (if you trust it!):

	```
	% xattr -d com.apple.quarantine usbipd-v0.6.0-macos-arm64
	```

- You might want to shorten the name:

	```
	% mv usbipd-v0.6.0-macos-arm64 usbipd-v0.6.0
	```

- Make it executable:

	```
	% chmod +x usbipd-v0.6.0
	```

- Move to a suitable location, expected to be within your `PATH`.

	If you don't rename it, use a symbolic link:
	
	```
	% mv usbipd-v0.6.0 ~/bin
	% cd ~/bin
	% ln -s usbipd-0.6.0 usbipd
	```

- Test:

	```
	% cd ~
	% usbipd --version
	USB/IP Daemon for macOS
	Version: 0.6.0
	Build: release
	```

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

>Notice the `10c4:ea60`. These are USB identifiers depending on the port you attached the cable to. The other option is `303a:1001` for the JTAG-capable port.

Here, the device is connected in the port `1-1`. Your port may be different; use the port reported.

```
% usbipd bind 1-1
Note: no daemon is running, so this was recorded for the next start.
✓ Device 1-1 added to server configuration
Bound device 1-1: 10c4:ea60 (CP2102N USB to UART Bridge Controller)
Registered for USB/IP sharing. No driver or process holds this device.
```

>1. `"no daemon is running"`.
>	In order for the USB device to be served (over IP), you'll need to also run a daemon. We'll come to that, shortly.
>2. `"No driver or process holds this device."`. This means *all* of your device gets to the VM. 
>
>	**This is not so** with the other, JTAG-capable port. There 2/3 USB profiles make it, but one (serial port) remains tied to macOS, because Mac recognized that signature.
	

<!-- Same for JTAG:

% usbipd bind 0-1
Note: macOS holds some interfaces of 0-1 (AppleUSBACMControl).
Interface 1, 2 is free and will be served — for a debug probe
that is the debug interface; the serial port stays with macOS.
Note: no daemon is running, so this was recorded for the next start.
✓ Device 0-1 added to server configuration
Bound device 0-1: 303a:1001 (USB JTAG_serial debug unit)
Registered for USB/IP sharing. The free interface is served;
the interfaces macOS holds are not.
-->

## daemon

Let's start the daemon.

>There are a few ways to this, and the author isn't sure of their pros/cons. If you are using Homebrew, resort to the official documentation.
>
>|||
>|---|---|
>|`usbipd daemon`|
>|`usbipd daemon --foreground`|

```
% usbipd daemon       
USB/IP daemon started on port 3240
Running in background mode.
USB/IP daemon started in background mode.
[...]
```

>In reality, there are quite many `[INFO]` logs. The author does not know how to lift the logging level to warning. `#help`

I expected this to return to the command line, but it does not. If I `Ctrl-C` that, there's no daemon running. A bit strange.

```
% usbipd daemon --foreground
USB/IP daemon started on port 3240
Running in foreground mode. Press Ctrl+C to stop.
Note: In the MVP, the server will run until the process is terminated.
In a full implementation, the server would handle signals properly.
USB/IP daemon running in foreground. Press Ctrl+C to stop.
[...]
```

**This is the mode the author prefers.**


## Where are we now?

- The devkit is bound to `usbipd`,
- ..ready to serve it further over IP.

If you were to close the terminal, or restart the machine, you need to exercise the `usbipd bind` and `usbipd daemon` again. This is mostly by design; the author uses the tool only occasionally, anyways.

>tbd. Instructions on how to set up `usbipd` as an automatically restarting daemon are welcome (once you have tested that yourself, of course!). 😃


<!-- #hidden
## Useful commands

### Spot an actual daemon

```
% ps aux | grep usbipd
```
-->

## Credits

<font size=+4>👏</font> for `beriberikix` for porting USB/IP to the macOS! 
