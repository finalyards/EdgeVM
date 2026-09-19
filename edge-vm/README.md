# `edge-vm`

Follow the main `README` to set up the VM.


## `espflash` remoting

With [`probe-rs-remote`](https://github.com/finalyards-org/probe-rs-remote/blob/main/README.md), you can connect to a dedicated device, e.g. a Raspberry Pi, on your network that has the devkit(s) connected.

<!-- tbd. image showing the relations -->

### Prepare the RPi

See the instructions in the above repo, and set up a proxy device.

You don't need to have a devkit connected to it, yet.


### Client support already set up

The VM has client side `espflash` and `probe-rs` set up, pointing to `rpi.local`. If your machine has another IP/domain name, edit `~/.bashrc` and re-read it.

```
$ echo $PROBE_RS_REMOTE
probe-rs@rpi.local
```

### `ssh` manual finishing

To make sure you are not asked for the password each time you flash something:

```
$ ssh-copy-id probe-rs@rpi.local
[...]
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
[...]
probe-rs@rpi.local's password: **fill here**

Number of key(s) added: 1

Now try logging into the machine, with: "ssh 'probe-rs@rpi.local'"
and check to make sure that only the key(s) you wanted were added.
```

Test it:

```
$ espflash --version
espflash 4.5.0
```

If this succeeds, you can also flash with `espflash` (or `probe-rs`), remotely. ☀️☀️

