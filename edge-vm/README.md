# `edge-vm`

Follow the main `README` to set up the VM.


## Preparing to flash

You have two options here:

### A. USB/IP

<!-- tbd. image here! -->

With USB/IP, you run the USB protocol - over IP - to within the VM, where it gets turned back to USB packets. You then run *normal* developer tools (`probe-rs` and `espflash` are frequently used in the Rust ecosystem). 

This is highly useful for local installations, but loses speed when applied over, say, a WLAN connection. This is because the USB and IP are *fundamentally different* protocols, and the traffic often ends up being short packages back and forth (polling-like), sensitive more on latency than bandwidth.

See [Using `usbip`](./Using usbip.md) for more details.

### B. Remoting

<!-- tbd. image here! -->

With remoting, either [using built-in](https://bugadani.github.io/rust/probe-rs/2025/02/20/probe-rs-server.html) or [`probe-rs-remote`](https://github.com/finalyards-org/probe-rs-remote/blob/main/README.md), you gain more speed (and maybe reliability). This means you might have a separate physical computer (e.g. a Raspberry Pi) that connects to your devkits. 

The author uses this mode, whenever there are custom electronics involved. It eliminates anxiety nicely!

See [Using remoting](./Using remoting.md) for more details.


## Rust Rover Remote Development

*tbd.*
