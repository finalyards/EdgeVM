# Debugging Lima

## Tracking the VM creation

You have two ways to see what's happening in the VM creation. This is useful e.g. if the build seems stuck. Or just for curiousity.


### Progress flag

```
% make edge PROGRESS=1
limactl start --name=edge-vm --mount-none -y --progress -- edge-vm/project.yaml
...
INFO[0043] [hostagent] Waiting for the essential requirement 2 of 3: `user session is ready for ssh` 
```

This prints progress of your provisioning steps.


### Tail the log

While the command is running:

```
% tail -f /Users/xxx/.lima/edge-vm/serial*.log
```

This can reveal e.g. interactive prompts.

```
================================================================================
  Serial                                                              [ Help ]
================================================================================
                                                                              
  As the installer is running on a serial console, it has started in basic    
  mode, using only the ASCII character set and black and white colours.       
                                                                              
  If you are connecting from a terminal emulator such as gnome-terminal that  
  supports unicode and rich colours you can switch to "rich mode" which uses  
  unicode, colours and supports many languages.                               
                                                                              
  You can also connect to the installer over the network via SSH, which will  
  allow use of rich mode.                                                     
                                                                              
                          [ Continue in rich mode  > ]                        
                          [ Continue in basic mode > ]                        
                          [ View SSH instructions    ]      
```
