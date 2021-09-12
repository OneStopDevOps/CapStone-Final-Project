# Output variable that holds the public IP of the AWS EC2 instances
output "jenkins_ip" {
  description = "EC2 jenkins IP"
  value       = aws_instance.instance.*.public_ip
} 

output "prod_ip" {
  description = "EC2 prod IP"
  value       = aws_instance.prod_instance.*.public_ip
} 