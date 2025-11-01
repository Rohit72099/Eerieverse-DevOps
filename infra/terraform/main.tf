resource "aws_instance" "app_server" {
  ami           = var.app_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.eerieverse_sg.id]

  tags = {
    Name = "EerieVerse-App"
  }
}

resource "aws_instance" "nagios_server" {
  ami           = var.monitor_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.eerieverse_sg.id]


  tags = {
    Name = "EerieVerse-Nagios"
  }
}

resource "aws_security_group" "eerieverse_sg" {
  name        = "eerieverse-sg-${formatdate("YYYYMMDD-HHmm", timestamp())}"
  description = "Security group for EerieVerse application"
  
  lifecycle {
    create_before_destroy = true
  }

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  # Node.js application port
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Node.js application port"
  }

  # Nagios NRPE
  ingress {
    from_port   = 5666
    to_port     = 5666
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Nagios NRPE"
  }

  # Allow all outbound traffic (including MongoDB Atlas)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}
