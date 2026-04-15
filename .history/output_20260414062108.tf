output "public" {
    value = aws_lightsail_instance.server1.public_ip_address 
}

output "username" {
    value = aws_lightsail_instance.server1.server.username 
}

output "ssh-command" {
    value = "ssh -i ${local_file.ssh_key}"
  
}