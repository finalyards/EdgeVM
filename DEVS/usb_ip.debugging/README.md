# Debugging

Running analysis on the [ESP32-C6-DevKitM-1](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c6/esp32-c6-devkitm-1/user_guide.html).

<img width=300 src="https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c6/_images/esp32-c6-devkitm-1-isometric.png" />



## `./Scripts/validate-usb-entitlements.sh` runs

### JTAG port (the right one)

[results](./jtag/report.md) (`303a:1001`)

|variant|verdict|
|---|---|
|baseline|2/3 interfaces open; the rest are held by a kernel driver|
|sandboxed-only|BLOCKED — kernel driver owns the device; requires DriverKit-level rebinding|
|sandboxed-usb|2/3 interfaces open; the rest are held by a kernel driver|
|usb-only|2/3 interfaces open; the rest are held by a kernel driver|

#### Analysis

- [ ] What does "2/3 interfaces open" mean?  Would this be usable with flashing from a VM (`espflash`)

- [ ] What is the one interface that isn't open?

- [ ] Can I release it?

<!-- #later
`sandboxed-only` is clearly out of the picture. 

- [ ] Which variant am I normally using; how to steer it?
-->


### UART port (the left one)

[results](./uart/report.md) (`10c4:ea60`)

|variant|verdict|
|---|---|
|baseline|USABLE TODAY — full userspace access without any special entitlement|
|sandboxed-only|BLOCKED — kernel driver owns the device; requires DriverKit-level rebinding|
|sandboxed-usb|USABLE TODAY — full userspace access without any special entitlement|
|usb-only|USABLE TODAY — full userspace access without any special entitlement|

#### Analysis

Looks good.

- [ ] How can I make sure I won't be in `sandboxed-only` mode?

