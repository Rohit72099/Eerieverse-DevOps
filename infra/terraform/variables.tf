variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "eerieverse-key"
}

variable "app_ami" {
  default = "ami-0f58b397bc5c1f2e8"
}

variable "monitor_ami" {
  default = "ami-0f58b397bc5c1f2e8"
}
