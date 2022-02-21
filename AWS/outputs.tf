output "instance_id1" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server[0].id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server[0].public_ip
}

output "subnet_id" {
  value = aws_subnet.instance_subnet.id
}
