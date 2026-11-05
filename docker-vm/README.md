# `docker-vm`

Follow the main `README` to set up the VM.


## `docker`

The YAML sets up a Linux VM with `docker` in it.


This is the way the author prefers to use Docker.

### Launch

In the parent folder:

```
% make docker
...
lima@lima-docker-vm:~$
```

You are taken right away into the VM.

#### Add to group to avoid `sudo` (work-around!!!)

```
$ newgrp docker
```

Provide this once **after each VM restart**.

>Background:
>
>It requires an interactive session. Lima VM creates the user session *prior to* the `mode: system` steps, and continues using the same session for the prompt.. So adding the user to the `docker` group in provisioning does not take effect.

>*tbd. Suggestions for making this work automatically are appreciated!* `#help` 

### Test

```
$ docker run hello-world
```

