## Using remoting

We discuss the use of [`probe-rs-remote`](https://github.com/finalyards-org/probe-rs-remote/blob/main/README.md) to proxy either (or both) `probe-rs` and/or `espflash` to another computer, connected to the devkit(s).

---

Since you are developing within a VM, you cannot simply plug in a target device (Lima VM does not provide USB pass-throughs).

There are three solutions to this.

1. `probe-rs` has [built-in remoting](https://bugadani.github.io/rust/probe-rs/2025/02/20/probe-rs-server.html) (blog, Feb'25)

2. USB/IP carries USB protocol over the IP

	Works but can be slow. IP protocol is not well adjusted to a lot of small, back and forth messages.

3. [probe-rs-remote](https://github.com/finalyards-org/probe-rs-remote)

	Proxies either `probe-rs` and/or `espflash` commands via a proxy script within the VM, over ssh, to the physical device running the real things.

### Steps to use `probe-rs-remote`

Your remote device has an IP, e.g. `192.168.1.97`. Edit this in the `.bashrc` and `~/.ssh/config` files, within the VM image.

<!-- #whisper
The baking in of `PROBE_RS_REMOTE` in the VM creation is intended to help eliminate needing to edit files within the VM. #later
-->

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


## Hints

### Passwordless `ssh`

```
$ ssh-copy-id probe-rs@192.168.1.97
```

<!-- tbd. Make *also that* part of the VM creation?? somehow.
-->

This exchanges keys with the remote device so that plain `ssh` just works. Recommended!

