// Creating security group

resource "aws_security_group" "security_group" {

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "Allow HTTP from anywhere"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 signifies all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "securitygroup-detail" {
  value = aws_security_group.security_group.id
}
