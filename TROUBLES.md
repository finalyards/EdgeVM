# Troubleshooting

## Errors when launching the VM shell

```
% limactl shell edge-vm 
bash: line 1: cd: /Users/asko/Git/ezb-node: No such file or directory
bash: line 1: cd: /Users/asko: No such file or directory
```

This is harmless. It's caused by Lima VM (2.3.0-beta.0) attempting to `cd` to your *host side* path when a folder has been mounted to the VM with another path.

**Example.**

1. Mount a folder `/Users/jack/Abc` as `/lima/home/Abc` (EdgeVM mounts all folders in the VM home directory)

2. exit the VM

3. Be *inside the said, mounted folder* on the host. There:

	```
	% limactl shell edge-vm
	```

**Work-around**

```
% limactl shell --workdir /home/lima/Abc edge-vm
lima@lima-edge-vm:~/Abc$
```


