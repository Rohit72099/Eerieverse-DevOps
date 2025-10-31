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
  name        = "eerieverse-sg"
  description = "Allow SSH, HTTP, and Nagios"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5666
    to_port     = 5666
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
