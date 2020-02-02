resource "aws_iam_role_policy" "web_policy" {
  name = "web_policy"
  role = aws_iam_role.web_role.id

  policy = file("iam/web-policy.json")
}

resource "aws_iam_role" "web_role" {
  name = "web_role"

  assume_role_policy = data.template_file.web_asume_role.rendered
}

resource "aws_iam_instance_profile" "web_profile" {
  name = "web_profile"
  role = "${aws_iam_role.web_role.name}"
}

data "template_file" "web_asume_role" {
  template = "${file("iam/policy-assume-role.tpl")}"
  vars = {
    service_name = "ec2"
  }
}