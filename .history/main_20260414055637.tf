# Generates a secure private and public key  and encodes it as PEM
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# Create the Key Pair
resource "aws_lightsail_key_pair" "ec2_key2" {
  name   = "week9d1"
  public_key = tls_private_key.ec2_key.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "week7d2.pem"
  content  = tls_private_key.ec2_key.private_key_pem
}
