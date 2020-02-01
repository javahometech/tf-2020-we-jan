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