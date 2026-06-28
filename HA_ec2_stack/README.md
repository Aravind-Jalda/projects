# Highly Available EC2 Web Server Stack with Auto-Scaling (Terraform)

This repository contains Infrastructure as Code (IaC) written in Terraform to provision a highly available, fault-tolerant web server stack on AWS. It demonstrates production-ready networking and compute architecture.

## 🏗️ Architecture Overview

- **Custom VPC:** Deployed across 2 Availability Zones for redundancy.
- **Public Subnets:** Hosts the Application Load Balancer (ALB) and NAT Gateway.
- **Private Subnets:** Hosts the EC2 instances. They have no direct public IP, securing them from internet-based attacks. Outbound internet access is routed via the NAT Gateway.
- **Application Load Balancer (ALB):** Distributes incoming HTTP traffic across healthy EC2 instances.
- **Auto Scaling Group (ASG):** Automatically provisions instances using a Launch Template. Uses ELB health checks to automatically replace unhealthy instances.
- **Zero-Trust Security Groups:** The EC2 instances are configured to *only* accept inbound traffic originating from the ALB Security Group.

## 🚀 Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (>= 1.0.0)
- AWS CLI installed and configured (`aws configure`) with appropriate permissions.

## 🛠️ Usage Instructions

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd ha-ec2-stack
   ```

2. **Initialize Terraform:**
   Downloads the required AWS provider plugins.
   ```bash
   terraform init
   ```

3. **Plan the deployment:**
   Review the resources that will be created.
   ```bash
   terraform plan
   ```

4. **Apply the configuration:**
   Provision the infrastructure in your AWS account.
   ```bash
   terraform apply
   ```

5. **Verify the deployment:**
   Once applied, Terraform will output a variable called `alb_dns_name`. 
   Paste this DNS name into your browser. Refresh the page a few times—you should see the `Instance ID` and `Availability Zone` change as the Application Load Balancer routes your request across different EC2 instances.

## 🧹 Clean Up

To avoid incurring future AWS charges, destroy all provisioned resources when you are done testing:
```bash
terraform destroy
```
