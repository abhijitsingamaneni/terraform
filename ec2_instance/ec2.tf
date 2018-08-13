
# provider is used to specifiy the region in which you want to deploy the  ec2 instance.
provider "aws" {
  region             = "us-east-1"
}

# variable are use to pass the default values

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

#resource is used  to create actual ec2 instance using variable, data and also provider
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.type}"

  tags {
    Name = "${var.TAG}"
  }
  # this is useful when you want to create the new instance before the older instance is destroyed

  lifecycle {
    create_before_destroy = true
  }
}
