output "app_instance_ip" {
  value = aws_instance.app_server.public_ip
}

output "nagios_instance_ip" {
  value = aws_instance.nagios_server.public_ip
}
