resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "JavaHomeVpc"
    Batch = "Weekend"
  }
}


resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Subnet-1"
    Batch = "Weekend"
    Location = "Banglore"
  }
}