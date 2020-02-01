
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name       = "JavaHomeVpc-${terraform.workspace}"
    Batch      = "Weekend"
    Environmet = terraform.workspace
  }
}

resource "aws_subnet" "public" {
  count             = local.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = local.az_names[count.index]
  tags = {
    Name       = "PublicSubnet${count.index + 1}-${terraform.workspace}"
    Environmet = terraform.workspace
  }
}

resource "aws_subnet" "private" {
  count             = local.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, local.az_count + count.index)
  availability_zone = local.az_names[count.index]
  tags = {
    Name       = "PrivateSubnet${count.index + 1}-${terraform.workspace}"
    Environmet = terraform.workspace
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name       = "javahome-igw"
    Environmet = terraform.workspace
  }
}

resource "aws_route_table" "prt" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "a" {
  count          = local.az_count
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.prt.id
}

