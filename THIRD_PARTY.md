# Third party

## `usbipd-mac`

### 1. Release guidance

Does the "Manual Installation" guide in [release 0.6.0](https://github.com/beriberikix/usbipd-mac/releases) lag behind:

>Manual Installation:
>
>1. Download `usbipd-v0.6.0-macos` and `USBIPDSystemExtension.systemextension.tar.gz`
>2. Make the binary executable: `chmod +x usbipd-v0.6.0-macos`
>3. Extract and install the system extension bundle
>4. Install the system extension: `sudo ./usbipd-v0.6.0-macos install-system-extension`

- [ ] The binary does not recognize `install-system-extension` parameter

	- [ ] Or is it because I took the `-macos-arm64` version
	- [ ] What is the role of the base `-macos` now? Is it still needed?

- [ ] If one only wants access to USB devices not recognized by the macOS host, there is no need for the system extension (as described in the project's main [`README`](https://github.com/beriberikix/usbipd-mac#there-is-no-system-extension)).


### 2. Steering the logging level

Can the logging level be steered with some env.var?

```
% sudo usbipd daemon --foreground
...
USB/IP daemon started on port 3240
Running in foreground mode. Press Ctrl+C to stop.
Note: In the MVP, the server will run until the process is terminated.
In a full implementation, the server would handle signals properly.
USB/IP daemon running in foreground. Press Ctrl+C to stop.
2026-09-04 21:34:52.259 [INFO] TCP server started successfully {port=3240}
2026-09-04 21:34:52.259 [INFO] USB/IP server started successfully {port=3240}
2026-09-04 21:34:52.259 [INFO] Command executed successfully {command=daemon}
2026-09-04 21:34:52.259 [INFO] Daemon mode detected, keeping process alive
2026-09-04 21:34:52.260 [INFO] Running in foreground mode
^C2026-09-04 21:35:58.236 [INFO] Received SIGINT, shutting down gracefully
```

