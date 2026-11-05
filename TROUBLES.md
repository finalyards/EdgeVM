# Troubleshooting

<!-- should be gone (depends on Lima version)
## Errors when launching the VM shell

```
% limactl shell edge-vm 
bash: line 1: cd: /Users/asko/Git/ezb-node: No such file or directory
bash: line 1: cd: /Users/asko: No such file or directory
```

This is harmless. It's caused by Lima's defined order of deciding where to land in the VM:

- in the folder provided by `--workdir`
- in the *host side* working dir path (which does not exist because of our sandboxing)
- in `/home/lima`


**Example.**

1. Mount a folder `/Users/jack/ABC` as `/lima/home/ABC` (EdgeVM mounts all folders in the VM home directory)

2. exit the VM

3. Be *inside the said, mounted folder* on the host. There:

	```
	% limactl shell edge-vm
	```

**Work-arounds**

```
% limactl shell --workdir /home/lima/Abc edge-vm
```

or using bare `ssh`:

```
% ssh -t -F ~/.lima/edge-vm/ssh.config lima-edge-vm "cd /home/lima/Abc && exec \$SHELL -l"
```

The plain `ssh` is clearly longer, but [somewhat recommended](https://github.com/lima-vm/lima/issues/3613#issuecomment-2949604003), at least as inside Lima discussions. (did not find a hard document ruling it over `limactl shell`).

You might want to make aliases for such a command, or simply launch VM's to their home, and `cd` manually, once in.


### References

- Lima documentation / Usage / [ssh](https://lima-vm.io/docs/usage/ssh/)
-->
