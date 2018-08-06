# provider is used to specifiy the region in which you want to deploy the  ec2 instance.
provider "aws" {
  region             = "us-east-1"
}

# variable are use to pass the default values for the variable

variable "TAG" {
  description = "tag to be passed to the instance"
  default = "ec2"
}

variable "type" {
  description = "type of ec2 instance"
  default = "t2.micro"
}

# data is used to get the ami id of the newly updated ubuntu ami with out you passing the AMI as variable

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Luanch configuration resource is used to create a new Luanch configuration
resource "aws_launch_template" "ec2" {
  name_prefix         = "ec2-"
  image_id            = "${data.aws_ami.ubuntu.id}"
  instance_type       = "${var.type}"

  # this is useful when you want to create the new instance before the older instance is destroyed

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bar" {
  availability_zones  = ["us-east-1a"]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  launch_template = {
    id = "${aws_launch_template.ec2.id}"
    version = "$$Latest"
  }

  # this is useful when you want to create the new instance before the older instance is destroyed

  lifecycle {
    create_before_destroy = true
  }
}
