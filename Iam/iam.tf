provider "aws" {
}
module "IAM_Role_test" {
  source                       = "./modules/IAM_ROLE"
  aws_iam_role_name            = "Iamroletest"
  aws_iam_role_description     = "to test the script"
  aws_iam_role_path            = "/"
  aws_iam_trusted_entity       = "assume-role-policy"
  aws_provided_policies        = ["AdministratorAccess", "PowerUserAccess"]
  aws_iam_custom_policies      = ["Route53-change-emr-master", "emr-ec2-config-01"]
}

