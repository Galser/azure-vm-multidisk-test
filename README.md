# azure-vm-multidisk-test
Azure VM several disks per machine with for-each meta-parameter test

# Synopsis ?

This came as request from one of the customers 
If we have several VMs (let it be 2) and several disks per VM (also 2), with disk attachments and names based on some VM prefix,
how to make this in elegant way in TF code? 


# How-To

The idea is to generate map with disk names in advance, based on VM name prefix, and then user `for_each` meta-parameter to create attachment.

# Run logs and follow along 

## Quote from `null_resource` run log 

```bash
...
null_resource.infra_server[0] (local-exec): Creatin VM azobe0
null_resource.appdatadisk["3"] (local-exec): disk name azobe1-01
null_resource.infra_server[1] (local-exec): Creatin VM azobe1
null_resource.infra_server[0]: Creation complete after 0s [id=437889092974296512]
null_resource.appdatadisk["3"]: Creation complete after 0s [id=7028217118443575000]
null_resource.appdatadisk["0"] (local-exec): disk name azobe0-00
null_resource.appdatadisk["1"] (local-exec): disk name azobe0-01
null_resource.appdatadisk["2"] (local-exec): disk name azobe1-00
...
null_resource.appdatadisk1_attach["0"]: Creation complete after 0s [id=7206747716212915371]
null_resource.appdatadisk1_attach["3"] (local-exec): disk id to attach 7028217118443575000, VM : 1
null_resource.appdatadisk1_attach["1"] (local-exec): disk id to attach 4312867439250891517, VM : 0
null_resource.appdatadisk1_attach["2"] (local-exec): disk id to attach 1189100700189260020, VM : 1

```

# TODO

- [ ] convert `null_resource` demo into real VMs
- [ ] run test


# DONE
- [x] `null_resource` demo

