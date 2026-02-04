# AWS EC2 Provisioning & Strapi Deployment using Terraform

## Loom video: https://www.loom.com/share/6f50f9f3592a4b3996ea52e4539ee6ba

Project Summary:- 

This project demonstrates how I built a complete cloud setup **from scratch** using **Terraform (Infrastructure as Code)**.  
The project provisions an **AWS EC2 instance**, configures **network security using Security Groups**, manages **SSH key pairs automatically using Terraform**, and deploys a **Strapi application** on the server.

The main goal of this project:

- Terraform fundamentals  
- AWS EC2 provisioning  
- Security Groups (network firewall rules)  
- SSH key management using Terraform  
- Automated server bootstrapping  
- Real-world debugging during provisioning  

---

## High-Level Architecture

Local Machine
|
| Terraform (IaC)
v
AWS Account
|
+--> Security Group (22, 80, 443, 1337)
|
+--> EC2 Instance
|
+--> Node.js + PM2
|
+--> Strapi Application (Port 1337)


---

## Repository Structure

```text
terraform-ec2-strapi/
├── provider.tf        # AWS provider configuration
├── main.tf            # EC2 resource + provisioning logic
├── variables.tf       # Input variables (instance type, ports, key name, etc.)
├── terraform.tfvars   # Actual values for variables
├── key-pair.tf        # Terraform-managed SSH key pair
├── security-group.tf  # Security Group configuration
├── README.md          # Project documentation
└── .gitignore         # Ignore secrets and state files
```
---

##  SSH Key Pair Management (Using Terraform)
In this project, I did not create SSH keys manually.
Instead, Terraform generates and manages the key pair.

🔹 What Happens
Terraform generates a private key locally

Terraform uploads the public key to AWS as an EC2 key pair

The private key is stored locally as a .pem file

The EC2 instance is launched using this key pair

Terraform uses the same private key to SSH into EC2 for provisioning

🔹Where It Is Used

key_name = aws_key_pair.create_key.key_name
This ensures the EC2 instance is accessible only using the generated private key.

 Security Group Configuration
The Security Group acts as a virtual firewall for the EC2 instance.

🔹 Opened Ports
Port	Purpose
22	SSH access
80	HTTP
443	HTTPS
1337	Strapi application


🔹 Where It Is Used

vpc_security_group_ids = [aws_security_group.security_group.id]
☁️ EC2 Provisioning (main.tf)
Terraform is used to launch the EC2 instance and attach the Security Group and Key Pair.



##  Workflow (How Everything Works Together)

Terraform initializes the AWS provider

Terraform generates an SSH key pair

Terraform creates a Security Group with required ports

Terraform launches an EC2 instance

The EC2 instance is attached to the Security Group

The EC2 instance is accessible using the generated SSH key

Application setup is automated on the EC2 instance

Strapi is deployed and exposed on port 1337

## Commands Used
🔹 Terraform

```bash
Copy code
terraform init
terraform validate
terraform plan
terraform apply
```

🔹 SSH Access
```bash
Copy code
chmod 400 <key-name>.pem
ssh -i <key-name>.pem ec2-user@<EC2_PUBLIC_IP>
```

##  What I Learned
Real-world Terraform workflows

AWS networking and security concepts

SSH key management using IaC

Debugging provisioning issues (SSH, cloud-init, package managers)

End-to-end cloud deployment from scratch


###  Conclusion
This project showcases a complete AWS + Terraform workflow.
It demonstrates my understanding of cloud infrastructure, security basics, automation, and practical DevOps workflows.













