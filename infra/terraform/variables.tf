variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "eerieverse-key"
}

variable "app_ami" {
  default = "ami-0c2b8ca1dad447f8a"
}

variable "monitor_ami" {
  default = "ami-0c2b8ca1dad447f8a"
}
