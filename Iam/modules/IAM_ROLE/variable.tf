variable "aws_iam_role_name" {
  default                                   = ""
  description                               = "Name of the IAM Role"
}
variable "aws_iam_role_description" {
  default                                   = ""
  description                               = "Description for the IAM Role"
}
variable "aws_iam_role_path" {
  default                                   = ""
  description                               = "Path of the IAM Role"
}
variable "aws_iam_trusted_entity" {
  default                                   = ""
  description                               = "Trusted entity for the IAM Role"
}
variable "aws_provided_policies" {
  default                                   = []
  type                                      = "list"
  description                               = "AWS provided polocies that needs to attached to the IAM Role"
}
variable "aws_iam_custom_policies" {
  default                                   = []
  type                                      = "list"
  description                               = "UCSF custome polocies that needs to attached to the IAM Role"
}