variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "Choose CIDR for Vpc"
  type        = string
}

variable "region" {
  default     = "ap-south-1"
  description = "Choose region when you want to create your resources"
  type        = string
}

variable "nat_ami" {
  type        = map
  description = "Choose AMI for NAT"
  default = {
    ap-south-1     = "ami-00b3aa8a93dd09c13"
    ap-southeast-1 = "ami-0012a981fe3b8891f"
  }

}

variable "web_ami" {
  type        = map
  description = "Choose AMI for web app"
  default = {
    ap-south-1     = "ami-0217a85e28e625474"
    ap-southeast-1 = "ami-05c64f7b4062b0a21"
  }

}