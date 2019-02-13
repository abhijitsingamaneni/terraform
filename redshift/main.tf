
data "aws_caller_identity" "current" {
}
resource "aws_iam_role" "aws_test" {
  name               = "${var.aws_iam_role_name}"
  description        = "${var.aws_iam_role_description}"
  path               = "${var.aws_iam_role_path}"
  assume_role_policy = "${file("${path.module}/Trusted_entity/${var.aws_iam_trusted_entity}.json")}"
}
resource "aws_iam_role_policy_attachment" "aws_provided_policies" {
  role               = "${aws_iam_role.aws_test.id}"
  count              = "${length(var.aws_provided_policies) > 0 ? length(var.aws_provided_policies) : 0}"
  policy_arn         = "arn:aws:iam::aws:policy/${var.aws_provided_policies[count.index]}"
}
resource "aws_iam_role_policy_attachment" "aws_iam_custom_policies" {
  role               = "${aws_iam_role.aws_test.id}"
  count              = "${length(var.aws_iam_custom_policies) > 0 ? length(var.aws_iam_custom_policies) : 0}"
  policy_arn         = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.aws_iam_custom_policies[count.index]}"
}

resource "aws_security_group" "redshift" {
  name                        = "${var.redshift_security_group}"
  description                 = "redshift security group"
  vpc_id                      = "${var.redshift_vpc}"

  ingress {
    from_port                 = 5439
    to_port                   = 5439
    protocol                  = "tcp"
    cidr_blocks               = ["0.0.0.0/0"]
  }

  egress {
    from_port                 = 0
    to_port                   = 0
    protocol                  = "-1"
    cidr_blocks               = ["0.0.0.0/0"]
  }
}

resource "aws_redshift_cluster" "default" {
  cluster_identifier           = "${var.unique_identifier}"
  database_name                = "${var.name_database}"
  master_username              = "${var.username_redshift}"
  master_password              = "${var.password_redshift}"
  node_type                    = "dc1.large"
  cluster_type                 = "single-node"
  iam_roles                    = ["${aws_iam_role.aws_test.arn}"]
  vpc_security_group_ids       = ["${aws_security_group.redshift.id}"]
  skip_final_snapshot          = true
}

resource "aws_s3_bucket" "b" {
  bucket                        = "${var.redshift_bucket}"
  acl                           = "private"

  versioning {
    enabled                     = true
  }
}