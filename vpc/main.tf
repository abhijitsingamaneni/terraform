
provider "aws" {
}
resource "aws_vpc" "main" {
  cidr_block                = "${var.vpc_cidr}"
  enable_dns_hostnames      = "${var.enable_hostnames}"
  enable_dns_support        = "${var.enable_dns}"

  tags {
    Name                    = "tf-${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name                     = "tf-internet-gateway-main-${var.vpc_name}"
  }
}

resource "aws_subnet" "vpc_subnets" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.vpc_subnets[count.index]}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
  count             = "${length(var.vpc_subnets)}"
  tags              = "${map("Name", format("tf-%s-subnet-app-%s", var.vpc_name, element(data.aws_availability_zones.available.names, count.index)))}"
}
