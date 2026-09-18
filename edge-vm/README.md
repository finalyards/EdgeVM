# `edge-vm`

Follow the main `README` to set up the VM.


## `espflash` remoting

<!-- tbd. image showing the relations -->

With [`probe-rs-remote`](https://github.com/finalyards-org/probe-rs-remote/blob/main/README.md), you can connect to a dedicated device, e.g. a Raspberry Pi, on your network that has the devkit(s) connected.

1. See the instructions in the above repo, and set up a proxy device.

	- You don't need to have a devkit connected to it, yet.

2. Once set up, let's see that we can reach it.

	```
	$ ping rpi.local
	PING rpi.local (192.168.1.105) 56(84) bytes of data.
	```
	
	>The URL may differ, use the one you know the target has. You can also use IP numbers.

	<p />
	
	>Note. If you only get one response from the `ping`, hit `Ctrl-C` and retry. This seems to always help.

3. &nbsp;

	```
	$ espflash --version
	```



## Rust Rover Remote Development

*tbd.*
