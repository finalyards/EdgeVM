```
[0;34m=== Preflight ===[0m
[0;32m[ OK ][0m macOS 27.0 (arm64)
[0;32m[ OK ][0m swiftc: Apple Swift version 6.3.3 (swiftlang-6.3.3.1.3 clang-2100.1.1.101)
[0;34m[INFO][0m SIP: System Integrity Protection status: enabled.
[0;34m[INFO][0m Running as uid 502. Re-run under sudo to capture the root results too.

[0;34m=== Auditing shipped entitlement files ===[0m
[0;32m[ OK ][0m No malformed or over-broad entitlement keys found

[0;34m=== Building probe ===[0m
[0;32m[ OK ][0m Built /Users/asko/Sources/usbipd-mac/.build/entitlement-validation/usb-claim-probe

[0;34m=== Running entitlement variants ===[0m
[0;32m[ OK ][0m baseline: completed, results in baseline.json
[0;32m[ OK ][0m usb-only: completed, results in usb-only.json
[0;32m[ OK ][0m sandboxed-only: completed, results in sandboxed-only.json
[0;32m[ OK ][0m sandboxed-usb: completed, results in sandboxed-usb.json
[1;33m[WARN][0m driverkit: process was killed at launch (exit 137).
[1;33m[WARN][0m          This is AMFI rejecting a restricted entitlement that has no
[1;33m[WARN][0m          matching provisioning profile — the expected result for driverkit.

[0;34m=== Comparison ===[0m
```

# USB entitlement validation results

- Host: macOS Version 27.0 (Build 26A5425a)
- Generated: 2026-09-09T07:22:40Z
- Variants compared: baseline, usb-only, sandboxed-only, sandboxed-usb

## Device open results by entitlement variant

| Device | Kernel driver | `baseline` | `usb-only` | `sandboxed-only` | `sandboxed-usb` |
| --- | --- | --- | --- | --- | --- |
| 303a:1001 USB JTAG_serial debug unit | AppleUSBCDCCompositeDevice, AppleUSBACMControl, AppleUSBACMData, IOSerialBSDClient | 2/3 ifaces · kIOReturnSuccess (0x0) | 2/3 ifaces · kIOReturnSuccess (0x0) | 0/0 ifaces · n/a | 2/3 ifaces · kIOReturnSuccess (0x0) |

## Interpretation

**Results differ between variants.** The per-device rows above show which entitlement set changed the outcome; that difference is the finding to report.

Devices whose `Kernel driver` column reads `none` are already fully usable from userspace with no entitlement at all. Devices with a driver listed are the ones a USB/IP server cannot serve without DriverKit-level rebinding.

### Variant `baseline`

- euid: 502 (non-root)
- seize attempted: false

- **303a:1001 USB JTAG_serial debug unit** — PARTIAL — 2/3 interfaces open; the rest are held by a kernel driver
  - iface 0 (class 2): AppleUSBACMControl [kernel driver] — open: kIOReturnExclusiveAccess (0xe00002c5)
  - iface 1 (class 10): AppleUSBACMData [kernel driver] — open: kIOReturnSuccess (0x0)
  - iface 2 (class 255): no driver — open: kIOReturnSuccess (0x0)

### Variant `usb-only`

- euid: 502 (non-root)
- seize attempted: false

- **303a:1001 USB JTAG_serial debug unit** — PARTIAL — 2/3 interfaces open; the rest are held by a kernel driver
  - iface 0 (class 2): AppleUSBACMControl [kernel driver] — open: kIOReturnExclusiveAccess (0xe00002c5)
  - iface 1 (class 10): AppleUSBACMData [kernel driver] — open: kIOReturnSuccess (0x0)
  - iface 2 (class 255): no driver — open: kIOReturnSuccess (0x0)

### Variant `sandboxed-only`

- euid: 502 (non-root)
- seize attempted: false

- **303a:1001 USB JTAG_serial debug unit** — BLOCKED — kernel driver owns the device; requires DriverKit-level rebinding

### Variant `sandboxed-usb`

- euid: 502 (non-root)
- seize attempted: false

- **303a:1001 USB JTAG_serial debug unit** — PARTIAL — 2/3 interfaces open; the rest are held by a kernel driver
  - iface 0 (class 2): AppleUSBACMControl [kernel driver] — open: kIOReturnExclusiveAccess (0xe00002c5)
  - iface 1 (class 10): AppleUSBACMData [kernel driver] — open: kIOReturnSuccess (0x0)
  - iface 2 (class 255): no driver — open: kIOReturnSuccess (0x0)

[0;34m=== Done ===[0m
[0;32m[ OK ][0m Report: /Users/asko/Sources/usbipd-mac/.build/entitlement-validation/report.md
[0;34m[INFO][0m Per-variant JSON and logs: /Users/asko/Sources/usbipd-mac/.build/entitlement-validation
[0;34m[INFO][0m Attach report.md to a new Feedback Assistant report — FB22897007 is closed
[0;34m[INFO][0m and no longer monitored.
