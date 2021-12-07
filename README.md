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
2. Create your credentils.tf file using the sample creds.tf file
3. ensure your provider is running the correct and latest version
4. gather your variable for your configuration, you should be able to add or remove pieces as needed
5. Modify `main.tf` with the variables that meet your naming standard
6. `terraform init`
7. `terraform plan`
8. `terraform apply`
