# F5 XC k0s Site Lab

## Overview

Terraform manifest to deploy F5 XC Kubernetes Sites based on k0s <https://k0sproject.io> on Fedora CoreOS <https://getfedora.org/en/coreos> Virtual Machine.
The required kubernetes site manifest is embedded in the ignition template and based on <https://gitlab.com/volterra.io/volterra-ce/-/blob/master/k8s/ce_k8s.yml>.

Each site creates the following topology for the kubernetes sites CE and the workload instance WL.

```
................. vpc .................
:   ... subnet ...                    :
:  :    +----+    :     +----------+  :
:  :    | CE |----------|          |  :    
:  :    +----+    :     | Internet |  :     
:  :       |      :     | Gateway  |--------- Internet
:  :    +----+    :     |   IGW    |  :   
:  :    | WL |----------|          |  :      
:  :    +----+    :     +----------+  :
:   ..............                    :
.......................................
```

Workload and CE VM use the default route to Internet via IGW and get specific routes for custom VIP available
on the CE Loadbalancer.

## Deployment

- Copy terraform.tfvars.example to terraform.tfvars and set the AWS and F5 XC credentials etc.
- Set the desired regions and number of sites per region in main.tf

Then run Terraform as usual

```
terraform plan
terraform apply
```

Site deployment time < 10 minutes
