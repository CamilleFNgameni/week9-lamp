# Generates a secure private and public key  and encodes it as PEM
resource "tls_private_key" "lightsail_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# Create the Key Pair
resource "aws_lightsail_key_pair" "lightsail_key2" {
  name   = "lamp"
  public_key = tls_private_key.lightsail_key.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "lamp.pem"
  content  = tls_private_key.lightsail_key.private_key_pem
}

  resource "aws_lightsail_instance" "server1" {
  name = "lamp-server"
  blueprint_id = "cen"
  bundle_id = "medium_1_0"
  availability_zone = "us-east-1a"
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo '<h1>This is deployed by Serge </h1>' | sudo tee /var/www/html/index.html
              sudo useradd serge 
              EOF
}

