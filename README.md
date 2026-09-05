# Edge

<!-- tbd. image of a blade
![](...)
-->


Collection of Lima VMs.

- [edge-vm](./edge-vm/)

	For Rust embedded development; targeting the [ESP32-C6](https://documentation.espressif.com/esp32-c6_datasheet_en.html).

	- Embassy
	- ESP-IDF; esp-idf-hal, esp-idf-sys, esp-idf-svc
	- USBIP client support

- [mini-vm](./mini-vm/)

	For Linux development, including:
	
	- Rust, 
		- including WASM target
	- node.js, npm

<!-- tbd.
- [cloud-vm](./cloud-vm/)

	For cloud development, including:
	
	- Rust, 
		- with WASM target (for Cloudflare workers)
	- node.js, npm

-->
- ...

You can do your own setups easily, or use these as-is.


## Requirements

<!--
The author develops this on macOS `aarm64`. Using on Linux and/or Windows host is likely possible, but not tested.
-->

- GNU Make (3.81)

	Part of Apple Command Line Tools:
	
	```
	% xcode-select --install
	```

### USB/IP daemon (optional; recommended)

If you plan to flash devices from the VM, you'll need `usbipd` running on some host. This host can be an external machine (e.g. a Raspberry Pi); it can be your local development machine.

|||
|---|---|
|macOS|See ["Setting up uspipd"](./Setting up usbipd.md)|
|Windows|*tbd.*|
|Linux|*tbd.*|

>Note: USB/IP is rather slow over a physical network hop (many small packages, back and forth); check out [`probe-rs-remote`](https://github.com/finalyards-org/probe-rs-remote/blob/main/README.md) (GitHub) for a faster alternative.


## Steps

### Create a VM environment

```
% make edge
limactl start --name=edge-vm --mount-none -y  -- edge-vm/project.yaml
[...]
INFO[0001] The instance edge-vm has shut down           
```

>The instance is stopped so that you can mount work folders to it. This is intended to be changed, having a `custom.mounts` file, from which folders are to be automatically mounted.

```
% limactl list
NAME           STATUS     SSH                VMTYPE    ARCH       CPUS    MEMORY    DISK     DIR
edge-vm       Stopped    127.0.0.1:49925    vz        aarch64    4       8GiB      40GiB    ~/.lima/edge-vm
```

>Note the ssh port (49925). It's important you use a separate port for each VM you run (e.g. in the 49922.. range).

### Mount the working folder(s)

The VM has been left in a stopped state with no host side folders shared. This allows you to edit its definition and add the shares.

Plan which folders you'd like to map. You can also add more later by stopping the VM (`limactl stop edge-vm`) and editing again.

|host|VM|
|---|---|
|`/Users/xxx/Git/Some`|`/home/lima/Some`|
|`/Users/xxx/Git/Other`|`/home/lima/Other`|
|...|

```
% limactl edit edge-vm

# Scroll to the end of the YAML and replace the file 'mounts: null' with e.g.
mounts:
  - location: "/Users/xxx/Git/SLED"
    mountPoint: "/home/lima/SLED"   
    writable: true
```

Save and exit.

```
? Do you want to start the instance now?  (Y/n) 
```

`Y`

```
...
INFO[0120] READY. Run `limactl shell edge-vm` to open the shell. 
```

```
% limactl shell edge-vm
```

Get comfortable within the Linux home:

```
lima@lima-edge-vm:~$ whoami
lima
lima@lima-edge-vm:~$ ls Some
{contents of your mapped folder}
```

With this setup, you can already build software for ESP32's. If you also wish to flash the devkit, read on...

### Accessing the devkit using USB/IP (optional)

>Note: Below, we treat the case where the *host* (same physical computer) runs `usbipd` (the daemon). You can use USB/IP also over an Ethernet or WLAN. Adjust the parameters accordingly.

1. Connect a devkit (with USB cable) to your devkit host.
2. Bind it

	```
	% usbipd bind 1-1
	```

	>Hint: Use `usbipd list` to see which port the devkit is connected to.
	
	```
	% usbipd daemon
	```

3. Attach to the VM

	```
	$ sudo usbip attach -r 192.168.5.2 -b 1-1
	```

	>Note: `192.168.5.2` is the IP normally pointing from Lima VM to its host. `1-1` varies, based on which USB port the devkit is connected to, on the host.

4. Test

	```
	$ lsusb
	[...]
	Bus 003 Device 002: ID 10c4:ea60 Silicon Labs CP210x UART Bridge
	[...]
	```

	>The `ID` is either `10c4:ea60` or `xxx:yyy`, based on which USB port you are connected to, on the devkit. Both should work.

5. Using `probe-rs` / `espflash`

	These two tools are pre-installed for flashing. 
	
	>Some embedded Rust projects are configured for `probe-rs`, others for `espflash`. Having both installed gives you a good starting position.

	```
	$ probe-rs info
	...tbd.
	```
	
	```
	$ espflash board-info
	[2026-09-05T20:15:22Z INFO ] Serial port: '/dev/ttyUSB0'
	[2026-09-05T20:15:22Z INFO ] Connecting...
	[2026-09-05T20:15:27Z INFO ] Using flash stub
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


### Exiting the VM

To exit, just:

```
$ exit
```


## Advanced

### Terminal profiles

The author likes to use a separate macOS terminal profile (right click > `Show inspector`) for the VMs. This helps keep the host side and VM side apart.

![](.images/terminal profiles.png)


### Renaming VM instances

Our `Makefile` does not support giving arbitrary names to the VM - this is partly by intention. If you have an older instance you might want to keep around, you can:

```
% limactl rename edge-vm edge-vm.was
```

## Summary

You now have:

- a VM running for Rust development
- Remote Development IDE to work with said environment

Have a look at the individual `README`s for the subfolders you have used. They might give more details about working with a certain development setup.

<!--
## References

...
-->
