provider "aws" {
  region             = "us-east-1"
}

variable "TAG" {
  description = "tag to be passed to the instance"
  default = "ec2"
}

variable "type" {
  description = "type of ec2 instance"
  default = "t2.micro"
}

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

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.type}"

  tags {
    Name = "${var.TAG}"
  }
}
