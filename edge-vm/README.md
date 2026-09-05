# `edge-vm`

Follow the main `README` to set up the VM.

## Using remote `probe-rs` and/or `espflash`

Since you are developing within a VM, you cannot simply plug in a target device (Lima VM does not provide USB pass-throughs).

There are three solutions to this.

1. `probe-rs` has built-in remoting

2. USB/IP carries USB protocol over the IP

	Works but can be slow. IP protocol is not well adjusted to a lot of small, back and forth messages.

3. [probe-rs-remote](https://github.com/finalyards-org/probe-rs-remote)

	What the author uses. Proxies either `probe-rs` and/or `espflash` commands via a proxy script within the VM, over ssh, to the physical device running the real things.

### Steps to use `probe-rs-remote`

Your remote device has an IP, e.g. `192.168.1.97`. Edit this in the `.bashrc` and `~/.ssh/config` files, within the VM image.

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


## Advanced (optional)

To not be asked for passwords:

```
$ ssh-copy-id probe-rs@192.168.1.97
```

This exchanges keys with the remote device so that plain `ssh` just works. Recommended!


## Remote Development (IDE; optional)

You can use an IDE on the host, and build/flash on the VM terminal.

But you can also set up a Remote Debugging IDE that runs *within* the VM. See `DEVS/` folder (informal notes) for guidance.



<!--
## References

- [`probe-rs`](https://probe.rs/docs/overview/about-probe-rs/)

-->