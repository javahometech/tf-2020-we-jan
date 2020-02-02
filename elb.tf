# Create a new load balancer
resource "aws_elb" "web_elb" {
  name            = "javahome-elb"
  security_groups = [aws_security_group.elb_sg.id]
  subnets         = local.pub_sub_ids
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.web_apps.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 30

  tags = {
    Name        = "javahome-elb"
    Environment = terraform.workspace
  }
}

resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "Manage traffic for elb"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
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