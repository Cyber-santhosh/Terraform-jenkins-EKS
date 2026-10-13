data "aws_ami" "ami_instance" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "azs" {}

data "aws_ec2_instance_types" "free_instances" {
  filter {
    name   = "free-tier-eligible"
    values = ["true"]
  }
}
