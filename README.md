# F5 XC k0s Site Lab

## Overview

Terraform manifest to deploy F5 XC Kubernetes Sites based on k0s <https://k0sproject.io> on Fedora CoreOS <https://getfedora.org/en/coreos> Virtual Machine.
The required kubernetes site manifest is embedded in the ignition template and based on <https://gitlab.com/volterra.io/volterra-ce/-/blob/master/k8s/ce_k8s.yml>.

The Terraform template module f5-xc-modules <https://github.com/cklewar/f5-xc-modules> is used and added as git submodule (don't forget to clone this repo with
`git clone --recursive-submodules`.

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
:   ..... AZ .....                    :
.......................................
```

Workload and CE VM are deployed in a subnet assigned to an availability zone (AZ) use the default route to Internet via IGW and get specific routes for custom VIP available
on the CE Loadbalancer. A nginx based web server is installed on the Workload VM and serves a welcome page on port 8080.

ssh access to CE and WL is available for username `core`.

## Deployment

- Copy terraform.tfvars.example to terraform.tfvars and set the AWS, F5 XC and ssh credentials etc.
- Set the desired regions and number of sites per region in main.tf

Then run Terraform as usual. Terraform manifest takes care of creating the AWS VPC, Subnet and IGW plus site token, namespace, site registration, virtual site, 
site mesh group and application LB and origin pool for the nginx webserver in the workload VM.

```
terraform plan
terraform apply
```

Site deployment time < 10 minutes
