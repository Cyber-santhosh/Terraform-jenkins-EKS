data "aws_availability_zones" "azs" {}

data "aws_ec2_instance_types" "free_instances" {
  filter {
    name   = "free-tier-eligible"
    values = ["true"]
  }
}
