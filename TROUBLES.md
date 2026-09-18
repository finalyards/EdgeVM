# Troubleshooting and Lima Feedback

## Errors entering the VM

```
% limactl shell edge-vm  
bash: line 1: cd: /Users/asko/Git/SLED: No such file or directory
bash: line 1: cd: /Users/asko: No such file or directory
```

Reason:

- `limactl` (2.2.0) by default tries to enter the *same* path as your host current working directory.
- Due to our sandboxing, it does not exist.

Work-around:

```
% limactl shell --workdir /home/lima edge-vm
```

**Upstream feedback?**

Suggest that if the folder does not exist, instead of printing the above errors, quietly move to the default VM home.

This would retain the existing functionality, but also feel natural when people have made stricter sandboxes 
of their VMs.


## Lima: Debugging

Lima could ease debugging of provisioning scripts by:

1. Stopping *ANY* later scripts from being executed if one fails

	Currently, they log:

	```
	INFO[0203] [cloud-init] LIMA 2026-09-18T11:30:25+01:00| WARNING: Failed to execute /mnt/lima-cidata/provision.user/00000004 (as user lima) 
	```
	
	...and continue to the next step.

	>Note that within the logging level, that's an `INFO`. Thus, changing logging level to `WARN` hides it.

2. Logging provisioning errors (see above) as `WARN` or `ERROR` log levels.

The YAML and the Makefile currently carry complexity because of this. A good approach could be to try to trim them down, showing where Lima workarounds have been employed.

This is a "long shot" but doing so would make Lima more expectable. Less surprises is good in software making!
