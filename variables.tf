

variable "instances" {
  description = "Map of EC2 instances (key=name, value=instance_type)"
  type        = map(string)

  default = {
    instance1 = "t3.micro"
    instance2 = "t3.micro"
  }
}


variable "ec2_default_root_storage_size" {
    description = "Size of root storage in GB"
    type        = number
    default     = 30
}

variable "ec2_ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
    default     = "ami-076838d6a293cb49e"
}

variable "env" {
    description = "Environment for the EC2 instance"
    type        = string
    default     = "dev"
}

variable "public_key_path" {
    description = "Path to the public key file"
    type        = string
    default     = "~/.ssh/id_rsa.pub"
}
