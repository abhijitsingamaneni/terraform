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

variable "unique_identifier" {
  description                               = "identifier for the redshift cluster"
}

variable "name_database" {
  description                               = "name of the database"
}

variable "username_redshift" {
  description                               = "user name for the redshift cluster"
}
variable "password_redshift" {
  description                               = "password for the redshift cluster"
}

variable "redshift_security_group" {
  description                               = "security group for the redshift"
}

variable "redshift_vpc" {
  description                               = "vpc for the redshift"
}

variable "redshift_bucket" {
  description                               = "bucket for the redshift"
}




