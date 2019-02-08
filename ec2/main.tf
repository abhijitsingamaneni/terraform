
# provider is used to specifiy the region in which you want to deploy the  ec2 instance.
provider "aws" {
}

# data is used to get the ami id of the newly updated ami with out you passing the AMI as variable
data "aws_ami" "ami" {
  most_recent                       = true

  filter {
    name                            = "name"
    values                          = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name                            = "virtualization-type"
    values                          = ["hvm"]
  }
}

#resource is used  to create actual ec2 instance using variable, data and also provider
resource "aws_instance" "ec2_instance" {
  #ami                               = "${var.aws_ami_id}"
  ami                               = "${data.aws_ami.ami.id}"
  instance_type                     = "${var.type}"
  subnet_id                         = "${var.subnet_id}"
  vpc_security_group_ids            = ["${var.security_groups}"]
  iam_instance_profile              = "${var.iam_role}"
  key_name                          = "${var.key_pair_name}"
  monitoring                        = "${var.monitoring}"
  associate_public_ip_address       = "${var.associate_public_ip_address}"

  tags {
    Name                            = "${var.TAG}"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  count                             = "${length(var.ebs_name) == 0 ? 0 : 1}"
  device_name                       = "${var.ebs_name}"
  volume_id                         = "${aws_ebs_volume.ebs_volume.id}"
  instance_id                       = "${aws_instance.ec2_instance.id}"
}

resource "aws_ebs_volume" "ebs_volume" {
  count                             = "${length(var.ebs_name) == 0 ? 0 : 1}"
  availability_zone                 = "${var.availability_zone}"
  size                              = "${var.ebs_size}"
  iops                              = "${var.ebs_iops}"
  

  tags = {
    Name                            = "tf-ebs-${var.TAG}"
  }
}
