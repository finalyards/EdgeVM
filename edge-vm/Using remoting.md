## Using remoting

<!-- #hidden
We discuss the use of [`probe-rs-remote`](https://github.com/finalyards-org/probe-rs-remote/blob/main/README.md) to proxy either (or both) `probe-rs` and/or `espflash` to another computer, connected to the devkit(s).
-->

Since you are developing within a VM, you cannot simply plug in a target device (Lima VM does not provide USB pass-throughs; it's [difficult on macOS](https://github.com/lima-vm/lima/issues/4766)).

There are (at least) three solutions to this.

1. USB/IP carries USB protocol over the IP

	Works but can be slow. IP protocol is not well adjusted to a lot of small, back and forth messages.
	
	macOS has no reliable open source USB/IP host, though [`usbipd-mac`](https://github.com/beriberikix/usbipd-mac) is being made... <sub>Version 0.6.0 doesn't cut our use case; tried it.</sub>

2. `probe-rs` has [built-in remoting](https://bugadani.github.io/rust/probe-rs/2025/02/20/probe-rs-server.html) (blog, Feb'25)

	The author sees this mostly as feature creep (it should be kept separate from the main flashing tool) and it would not solve the issue for `espflash`, anyhow.

3. [probe-rs-remote](https://github.com/finalyards-org/probe-rs-remote)

	Proxies either `probe-rs` and/or `espflash` commands via a proxy script within the VM, over `ssh`, to the physical device running the real things.
	
	>Note: The feature set is not 100%, but is enough for normal `cargo` use.

### Steps to use `probe-rs-remote`

Your remote device has an IP, e.g. `192.168.1.97`. Edit this in the `.bashrc` and `~/.ssh/config` files, within the VM image. 

>You can also use its `.local` domain, e.g. `rpi.local`.

Then:

```
$ espflash board-info
[...]
[2026-08-31T16:36:01Z INFO ] Serial port: '/dev/ttyUSB0'
[2026-08-31T16:36:01Z INFO ] Connecting...
[2026-08-31T16:36:02Z INFO ] Using flash stub
Chip type:         esp32c6 (revision v0.2)
Crystal frequency: 40 MHz
Flash size:        4MB
Features:          WiFi 6, BT 5
MAC address:       fc:01:2c:f9:09:b4

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

### Passwordless `ssh`

```
$ ssh-copy-id probe-rs@rpi.local
```

This asks for your remote password and exchanges keys so that in the future, `ssh` just works between the devices.
