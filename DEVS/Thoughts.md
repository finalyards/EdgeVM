# Thoughts...

Regarding Lima VM 2.2.0.

Rust Rover Remote Development 2026.2.1


## Problem:

It would be nice to have *each source repo* have a declarative way of defining "this is the way a VM should be set up".

Something like:

```
.lima/
   `-- lima.yaml
```

No Makefile. 

No shell commands.

Just `lima up` and you'd ... be running.


## Reality: Lima VM

The 2.2.0 version of Lima VM insists in sharing the *host* side `/Users/xxx/...` path *within the client*. This is not great for sandboxing.

This repo fights against that, but you can see that some error messages still show Lima VM's true colors.

Well, it's *"good enough for now"*.

## Reality: middle ground (ssh configs)

What's great is how Lima creates the `~/.lima/$(VM_NAME)/ssh.config` files.

These **could be used by the Remote Development feature automatically** to:

- see which VM's are set up
- to connect to them

This would mean no need to tie the said ssh configs to the main `~/.ssh/config` (which is a bit intrusive). It would mean no hassle setting up a new VM within Rust Rover. 

Just pick the Lima VM!


## Reality: IntelliJ Remote Development

It works.

It's should *feel* the same as the host side IDE, which is does not, yet.

The main burden, at the moment, is in the setting up, which this repo tries to smoothen.

Ideally, the repo becomes moot, because both Lima VM and IntelliJ Remote Development caught up, and fixed their current shortcomings.

Until then, Happy Coding! 🦀🪼


