
resource "tls_private_key" "tf_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "create_key" {
  key_name   = var.key_name
  public_key = tls_private_key.tf_key.public_key_openssh

  tags = {
    Name        = var.key_name
    Environment = var.environment
  }
}


resource "local_file" "private_key" {
  content         = tls_private_key.tf_key.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400"
}
