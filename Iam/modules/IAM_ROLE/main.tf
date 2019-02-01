
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