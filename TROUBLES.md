# Troubleshooting

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

