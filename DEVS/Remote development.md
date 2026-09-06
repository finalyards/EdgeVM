## Remote Development

If you feel you want to try Remote Development, here goes. 

This is with Rust Rover. Other IDEs (Visual Code) would work differently.


### Disclaimer: it's in beta

At the time of writing (Aug'26; RR 2026.2.1), the Remote Development from IntelliJ is still in beta and has certain shortcomings:

- Column editing mode does not work
- Dragging files to another window does not work

Also overall, you'll get *two* IDEs, one handling the files in host, another in the VM. This can be confusing, and the author understands IntelliJ is aiming at a more holistic approach, eventually.


### Requirement: direct `ssh` access

IntelliJ Remote Development cannot (as of Aug'26) pick up the `~/.lima/$(VM_NAME)/ssh.config` configurations that Lima VM automatically does (HINT: It would be great if it did!). This is why our `Makefile` has bound them to your main `~/.ssh/config`.

You should be able to:

```
% ssh lima-edge-vm
Last login: Mon Aug 31 07:38:08 2026 from UNKNOWN
lima@lima-edge3-vm:~$ 
```

This is a requirement for the IntelliJ Remote Development to work.

### Set up

- Within Rust Rover IDE
- `File` > `Remote Development`

	<!-- tbd. screenshots ...-->
	>Once set up, you will be able to click `SSH` and pick a suitable VM. But we need to set it up, first.
	
	- `New Connection`
	- "gear" icon next to the `Connection: <New Connection>`
	- `+`
	
	<!-- REALLY need screenshot here! -->
	
	- Fill in: 
		- `Host:` `lima-edge-vm`
		- `Port:` (the port in the YAML, e.g. `49925`)
		- `Username:` `lima` 
		- `Authentication type:` `OpenSSH config and authentication agent`

	- Press `Test Connection`

		If the test passes, press `OK`
	
	- Pick the created profile > `Check Connection and Continue`

	- Pick the remote IDE version (you could e.g. have stable and EAP, here)

	- `Project directory:` Choose by the `...` > `/home/lima/Some`

	- `Download IDE and Connect`

WHOA!!

The download is about 5GB. Let it roll..

>This is the reason for *reusing a VM* among multiple projects. IT'S HARD to get the Remote Development going, and each installation takes disk space. It's not Docker.

Once installed, the user experience is familiar. You now have *two* IDEs open - you can actually close the original Rust Rover and just keep the Remote one open.


### Hint: VM resources

Click the name of the VM in Remote Development (`lima-edge-vm`):

<!-- screenshot, again -->

This allows you to see the resources used by the VM.
