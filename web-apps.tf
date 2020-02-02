resource "aws_instance" "web_apps" {
  ami                    = "${lookup(var.web_ami, var.region)}"
  instance_type          = "t2.micro"
  subnet_id              = local.pub_sub_ids[0]
  user_data              = "${file("scripts/apache.sh")}"
  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]

  iam_instance_profile = aws_iam_instance_profile.web_profile.id

  tags = {
    Name        = "Web App"
    Environment = terraform.workspace
  }
}

// Security group for web apps

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Manage traffic for web apps"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.51.107.109/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}