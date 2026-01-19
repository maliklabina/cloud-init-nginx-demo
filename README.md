## Cloud-Init-Nginx-Demo

- This repository demonstrates how to create EC2 instances using Terraform in HCL language and automatically install Nginx on them using cloud-init.

- It is Free Tier friendly and ideal for learning Terraform, EC2, and cloud-init automation.

---
### Prerequisites

- An AWS account with access keys

- Terraform installed on your local machine

- SSH key pair for logging into EC2

## Steps to Deploy

- 1 Configure AWS CLI (optional, for testing locally):

```bash
 aws configure

 ```


- 2 Create an IAM user with necessary permissions in your AWS account.

 - Attach policies like AmazonEC2FullAccess and AmazonVPCFullAccess.

 - 3 Provide access keys to Terraform using environment variables or a provider block:

```bash
provider "aws" {
  region     = "us-east-1"
  access_key = "<YOUR_ACCESS_KEY>"
  secret_key = "<YOUR_SECRET_KEY>"
}
```


- 4 Write Terraform resources:

- Key pair, VPC data, subnets, security group, and EC2 instances.

- User data script to install Nginx automatically.

- 5 Initialize and apply Terraform:


```bash
terraform init
terraform apply -auto-approve
```

## Accessing the EC2 Instance

1- Change permissions for the key:
```bash
chmod 400 terra-key-ec2.pem
```

2- SSH into the instance:
```bash
ssh -i terra-key-ec2.pem ec2-user@<public_ip>
```

3- Check Nginx status inside the instance:
```bash
sudo systemctl status nginx
```
## Deleting Resources

1- To destroy all provisioned resources:
```bash
terraform destroy -auto-approve
```


### How Nginx is Installed and Runs

1- Terraform launches the EC2 instance with the user_data script attached.

2- cloud-init (a service preinstalled on Amazon Linux AMIs) detects the user_data script during the first boot and executes it automatically.

3- The install_nginx.sh script runs inside the EC2 instance as root, installing and starting Nginx:

```bash
#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl enable nginx
systemctl start nginx
```

4- Once executed, Nginx is up and running on the instance.

5- You can access Nginx using the EC2 public IP in your browser:

```bash
http://<public_ip>
```




## Visual Flow

Flow explanation:

- Terraform: Deploys EC2 with user_data.

- EC2 Instance: Receives the script.

- cloud-init: Executes the script on first boot.

- Nginx: Installed and started automatically, ready to serve HTTP requests.


## Key Features

- Automated provisioning of EC2 instances using for_each.

- Free Tier compatible (t2.micro).

- Root volume size ≥ 30GB to match AMI snapshot requirements.

- Security group allows SSH, HTTP, and HTTPS access.

- Outputs EC2 public/private IPs and DNS names.

- Beginner-friendly and reusable for learning DevOps concepts.
