resource "aws_instance" "nat" {
  ami               = "${lookup(var.nat_ami, var.region)}"
  instance_type     = "t2.micro"
  subnet_id         = local.pub_sub_ids[0]
  source_dest_check = false

  tags = {
    Name = "Nat Instance"
  }
}