# Edge

<!-- tbd. image of a blade
![](...)
-->


Collection of Lima VMs.

- [edge-vm](./edge-vm/)

	For Rust embedded development; targeting the [ESP32-C6](https://documentation.espressif.com/esp32-c6_datasheet_en.html).

	- Embassy
	- ESP-IDF; esp-idf-hal, esp-idf-sys, esp-idf-svc

	Can also be used for `no_std` (bare metal) development.

- [mini-vm](./mini-vm/)

	For Linux development, including:
	
	- Rust
		- including targeting WASM
	- node.js, npm

- ...

You can do your own setups easily, or use these as-is.


## Requirements

- GNU Make (3.81)

	This repo is made primarily for use on macOS. To have `make` available, install the Apple Command line Tools.
	
	```
	% xcode-select --install 
	```

## Steps

To create a VM environment:

```
% make edge
[...]
INFO[0001] The instance edge-vm has shut down           
```

```
% limactl list
NAME           STATUS     SSH                VMTYPE    ARCH       CPUS    MEMORY    DISK     DIR
edge-vm       Stopped    127.0.0.1:49925    vz        aarch64    4       8GiB      40GiB    ~/.lima/edge-vm
```

>Note the ssh port (49925). It's important you use a separate port for each VM you run (e.g. in the 49922.. range).

### Mount the working folder(s)

The VM has been left in a stopped state with no host side folders shared. This allows you to edit its definition and add the shares.

Plan which folders you'd like to map. You can also add more later by stopping the VM (`limactl stop edge-vm`) and editing again.

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

`Y`

```
...
INFO[0120] READY. Run `limactl shell edge-vm` to open the shell. 
```

```
% limactl shell edge-vm
```

<!-- is it for real, repeatable?
```
bash: line 1: cd: /Users/xxx/Git/SLED: No such file or directory
bash: line 1: cd: /Users/xxx: No such file or directory
```

On the *first* launch you'll see the errors above. DO NOT WORRY. This just means the host side `/Users` is not mapped to the VM (Lima VM should really not care!?). 
-->

```
lima@lima-edge-vm:~$ whoami
lima
lima@lima-edge-vm:~$ ls
{your mapped folders}
```

To exit the VM, just `exit`.

## Hints (optional)

### Terminal profiles

The author likes to use a separate macOS terminal profile (right click > `Show inspector`) for the VMs. This helps keep the host side and VM side apart.

![](.images/terminal profiles.png)


## Advanced

### Renaming VM instances

Our `Makefile` does not support giving arbitrary names to the VM - this is partly by intention. If you have an older instance you might want to keep around, you can:

```
% limactl rename edge-vm edge-vm.was
```

## Summary

You now have:

- a VM running for Rust development
- Remote Development IDE to work with said environment

Have a look at the individual `README`s for the subfolders you have used. They might give more details about working with a certain development setup.

<!--
## References

...
-->
