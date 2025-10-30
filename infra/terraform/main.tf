resource "aws_instance" "app_server" {
  ami           = var.app_ami
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "EerieVerse-App"
  }
}

resource "aws_instance" "nagios_server" {
  ami           = var.monitor_ami
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "EerieVerse-Nagios"
  }
}
