
## Using USB/IP (VM side)

### Requirements

You have a working `usbipd` server. See somewhere under `/DEVS/` folder for instructions regarding `usbip-mac`. Once it becomes more stable, we'll bring it down here.

### Steps

0. See there's a device

   ```
   $ usbip list -r 192.168.5.2
   Exportable USB devices
   ======================
    - 192.168.5.2
        1-1: Silicon Labs : CP210x UART Bridge (10c4:ea60)
           : /sys/devices/1-1
           : (Defined at Interface level) (00/00/00)
           :  0 - (Defined at Interface level) (00/00/00)
   ```

1. Attach the device

   >🆘
   >
   >```
   >$ sudo modprobe vhci_hcd
   >```
   >
   >This **SHOULD NOT be needed**; it's a bug if the `vhci_hcd` has not automatically been loaded!

   ```
   $ sudo usbip attach -r 192.168.5.2 -b 1-1
   ```

2. Test

	```
	$ lsusb
	[...]
	Bus 003 Device 002: ID 10c4:ea60 Silicon Labs CP210x UART Bridge
	[...]
	```

	>The `ID` is either `10c4:ea60` or `303a:1001`, based on which USB port you are connected to, on the devkit.

3. Testing `probe-rs` and/or `espflash`
	
	>Depending on the creation of the VM, you might have local `probe-rs` and/or `espflash` tools installed.
	>
	>Let's test both.
	
	```
	$ probe-rs list
	No debug probes were found.
	 WARN probe_rs::util::setup_hints::linux: If your probe is plugged in but not listed, or shown as inaccessible, it is most likely a permissions problem.
	 WARN probe_rs::util::setup_hints::linux: Your user needs read and write access to the probe's device node: a USB node under /dev/bus/usb, or a serial port such as /dev/ttyACM0.
	 WARN probe_rs::util::setup_hints::linux: See https://probe.rs/docs/getting-started/probe-setup/ for how to set up the required udev rules and group membership.
	```
	
	‼️THIS MEANS `probe-rs` is CURRENTLY NOT USABLE with USB/IP bridging. `#bug`
	
	```
	$ espflash board-info
	[2026-09-06T20:35:53Z INFO ] Serial port: '/dev/ttyUSB0'
	[2026-09-06T20:35:53Z INFO ] Connecting...
	<Ctrl-C>
	```
	
	Try again:

	```	
	$ espflash board-info
	[2026-09-06T20:36:23Z INFO ] Serial port: '/dev/ttyUSB0'
	[2026-09-06T20:36:23Z INFO ] Connecting...
	[2026-09-06T20:36:28Z INFO ] Using flash stub
	Chip type:         esp32c6 (revision v0.2)
	Crystal frequency: 40 MHz
	Flash size:        4MB
	Features:          WiFi 6, BT 5
	MAC address:       fc:01:2c:f9:04:38

	Security Information:
	=====================
	Flags: 0x00000000 (0)
	Key Purposes: [0, 0, 0, 0, 0, 0, 12]
	Chip ID: 13
	API Version: 0
	Secure Boot: Disabled
	Flash Encryption: Disabled
	SPI Boot Crypt Count (SPI_BOOT_CRYPT_CNT): 0x0

	```

	Needing to try twice (a repeatable pattern) means something in the chain is flaky.
	
	CANNOT RECOMMEND USING USB/IP, JUST YET.

## Once it works

Embedded Rust projects often bake support for either `probe-rs` or `espflash` into their `.cargo/config.toml` environment. This means you can simply `$ cargo run` and the code will be flased to your devkit.

See an example in [`Finalyards/SLED`](https://github.com/finalyards/SLED).

