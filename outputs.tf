
# outputs for count instances (using index)

# output "ec2_public_ip" {
#  description = "Public IP of the EC2 instance"
#  value = aws_instance.my_instance[*].public_ip
# } 

# output "ec2_public_dns" {
#  description = "Public dns of the EC2 instance"
#  value = aws_instance.my_instance[*].public_dns
#}  

# output "ec2_private_ip" {
#  description = "Private IP of the EC2 instance"
#  value = aws_instance.my_instance[*].private_ip
# }



# Outputs for for_each instances (using loop)

output "ec2_public_ip" {
  description = "Public IPs of the EC2 instances"
  value       = { for k, v in aws_instance.my_instance : k => v.public_ip }
}

output "ec2_private_ip" {
  description = "Private IPs of the EC2 instances"
  value       = { for k, v in aws_instance.my_instance : k => v.private_ip }
}

output "ec2_public_dns" {
  description = "Public DNS of the EC2 instances"
  value       = { for k, v in aws_instance.my_instance : k => v.public_dns }
}