# aci_tenant
Create a Tenant, VRF, BD, EPG and Contracts with Terraform on ACI

# This Modules uses the Cisco Devenet Sandbox for Always on ACI.

Usage:  

Navigate to the Cisco Dev Net Site and Login using your Cisco Credentials
[Cisco DevNet](https://https://devnetsandbox.cisco.com/RM/Topology/).

Credentials will be availiable in the section labeled:
Connecting to the ACI Server:

# terraform-aci-demo

## Local Runs
1. Git clone repo locally
2. Create your credentils.tf file using the credentials from always on sandbox


4. 
5. Modify `terraform.tfvars.sample` and update ACI URL, Username, Password.
6. Rename `terraform.tfvars.sample` to `terraform.tfvars`
7. `terraform init`
8.`terraform plan`
9. `terraform apply`
