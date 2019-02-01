resource "aws_iam_policy" "iam_custom_policy" {
  name        = "${element(keys(var.iam_policies), count.index)}"
  count       = "${length(keys(var.iam_policies))}"
  path        = "${var.iam_policy_path}"
  description = "${element(values(var.iam_policies), count.index)}"
  policy      = "${file("${path.module}/templates/${element(keys(var.iam_policies), count.index)}.json")}"
}


