
resource "aws_instance" "first-ec2-from-terraform" {
  ami                    = "ami-053b0d53c279acc90"
  key_name               = aws_key_pair.create_key.key_name
  vpc_security_group_ids = ["${aws_security_group.security_group.id}"]
  
  instance_type          = var.instance_type
  tags = {
    Name = "Deploy Strapi"
  }

  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = local_file.private_key.content
      host = "${self.public_ip}"
      agent = false
      timeout     = "5m"     
    }

provisioner "remote-exec" {
  inline = [
    "sudo cloud-init status --wait || true",
    "sudo apt update -y",
    "sudo apt install -y curl git",

    "curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -",
    "sudo apt install -y nodejs",

    "sudo npm install -g yarn pm2",

    "cd /home/ubuntu",
    "npx create-strapi-app@latest my-strapi --quickstart",

    "cd /home/ubuntu/my-strapi",
    "pm2 start yarn --name strapi -- start",
    "pm2 save"
  ]
}


}