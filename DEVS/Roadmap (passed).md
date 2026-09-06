# Roadmap (passed)

*Short description of the where the author came, where we are now (and perhaps of the future).*


## The original aim 🥅

It would be nice to have a *descriptive* way that defines the tools needed to work on a certain repository. This would make it easier for newcomers to get started, and document the *actual* minimal set of tools and libraries used.

Considered:

- Docker; just don't like to tie into its ecosystem. (Docker Compose is basically what I'm after, though.)
- Canonical's Multipass; have used for a while; liked but it is hardly maintained...

Come Lima VM.

This has everything (well, except for selective USB pass-through and some other things).

## Use case: plain

In this mode, one runs an IDE *host side*, the sources as shared with the VM; all build and pulling in dependencies happens client side.

This works. The author already had experience of it from Multipass, so that certain optimizations (keeping Rust/Cargo's `target` in a native folder; doing the same for `npm` `node_modules` were known to him).

⭐️⭐️⭐️⭐️

## Use case: Remote Development

I occasionally want to use the Rust Rover Remote Development add-on.

It's difficult to describe when this is needed. It may be some IDE code completion working weird; may be something else. But the *option* of being able to install and run a Remote Development instance within the VM sounds solid enough.


## Use case: AI/LLM sandbox

Not yet here. But I *do not trust* the harness rules to run LLM agents wild on my main account. This means the VM needs to function not only as a reproducible environment, but also as a *sandboxed* one.


## Design decisions

1. One VM to serve multiple, similar projects.

	This is a deviation of the author's original idea of having a declaration attached to each project. But such would easily become elaborate, since *also maintaining the VM definition* is a thing. And that thing is unrelated to said repo.
	
	Also, this emerges from the realization that there are only a limited number of VM *types* a developer normally uses.
	
	- desktop applications
	- embedded applications (target Y)
	- cloud applications

	What *really* anchored the choice was installing Rust Rover Remote Development component. It's a multi-GB download. You don't want to duplicate that, if you can avoid!!!

- ...?


## Reality: Lima VM

Here are some "rubber meets the road" cases, developing for Lima VM 2.2.0.

### Sandboxing???

This one is weird. If I use the "template" approach, all host side folders are shared. And they are shared with their host-side names.

- e.g. `/Users/{you}/Some`

To create a *reproducible* environment across multiple users, this is a no-no.

>The author found a way, quite a lot of time spent. Instead of `base: template` it's `images: location`.

🟩 Outcome: GOOD. Only specific folders are shared. 

>Such mounts need to now be manually edited into the VM. The author aims to automate creation by having a `custom.mounts` list, in the future.
>
>This way, it will be fast for you to recreate a *customized* VM with certain centrally maintained tooling (i.e. `git pull` helps keep the main YAML relevant, or allows you to suggest improvements to it).


### Rust Rover Remote Development; ssh!!!

>This falls fully on the IntelliJ's lap!


What's great is how Lima creates the `~/.lima/$(VM_NAME)/ssh.config` files.

These **could be used by the Remote Development setup automatically** to:

- see which VM's are set up (list the files; present them in a UI)
- connect to them

This would mean no need to tie the said ssh configs to the main `~/.ssh/config` (which feels a bit intrusive). It would mean no hassle setting up a new VM within Rust Rover!!! 

Just pick the Lima VM!

🟨 Outcome: Good enough work-around. There is a penalty (of complexity) each time you want to use Rust Rover Remote Development, but there is no implication to people not using it.

Things can improve. If you wish so, would you **draft an issue about this in IntelliJ YouTrack**. Thanks!!! 😀



