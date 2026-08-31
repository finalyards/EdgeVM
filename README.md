# Edge

<!-- tbd. image of a blade
![](...)
-->


Collection of Lima VMs.

- [edge-vm](./edge-vm/README.md)

	For Rust embedded development; targeting the ESP32-C6.

	- Embassy
	- ESP-IDF; esp-idf-hal, esp-idf-sys, esp-idf-svc

- ...

## Requirements

- GNU Make (3.81)

	This repo is made primarily for use on macOS. To have `make` available, install the Apple Command line Tools.
	
	```
	% xcode-select --install 
	```

## Steps

To create a VM environment:

```
% make -f edge-vm/Makefile vm
[...]
INFO[0085] READY. Run `limactl shell edge3-vm` to open the shell. 
```

```
% limactl list
NAME           STATUS     SSH                VMTYPE    ARCH       CPUS    MEMORY    DISK     DIR
edge-vm       Running    127.0.0.1:49925    vz        aarch64    4       8GiB      40GiB    ~/.lima/edge-vm
```

Note the ssh port (49925). It's important you use a separate port for each VM you run (e.g. in the 49922.. range).

### Mount the working folder(s)

It's convenient to use the same VM for multiple projects needing similar tools.

Plan which folders you'd like to map. You can also add more later by stopping the VM (`limactl stop edge-vm`).

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

Press `Y`.

```
...
INFO[0120] READY. Run `limactl shell edge3-vm` to open the shell. 
```

```
% limactl shell edge3-vm
bash: line 1: cd: /Users/xxx/Git/SLED: No such file or directory
bash: line 1: cd: /Users/xxx: No such file or directory
lima@lima-edge3-vm:~$
```

On the *first* launch you'll see the errors above. DO NOT WORRY. This just means the host side `/Users` is not mapped to the VM (Lima VM should really not care!?). 

```
lima@lima-edge3-vm:~$ whoami
lima
lima@lima-edge3-vm:~$ ls
SLED
```

To exit the VM, just `exit`.

### Visual help: Terminal profiles (hint)

The author likes to use a separate macOS terminal profile (right click > `Show inspector`) for the VMs. This helps keep the host side and VM side apart.

![](.images/terminal profiles.png)


## Remote Development (optional)

It's possible to run the IDE on the host side, and do builds, deployments etc. in a separate terminal within the VM. But this has its shortcomings.

The author does not currently remember them clearly. 🤪 ..but if you feel you want to try Remote Development, here goes.

This is with IntelliJ IDE. Other IDEs (Visual Code) would work differently.


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


## Summary

You now have:

- a VM running for Rust development
- Remote Development IDE to work with said environment

### Next steps

To flash your embedded work on a device, you either need to use USB/IP (attach a devkit via IP) or a remoting setup. See [probe-rs-remote](https://github.com/finalyards-org/probe-rs-remote) for a tool that makes remote `probe-rs` and `espflash` tools (these are alternatives) work like they were directly within the VM.


<!--
## References

...
-->
