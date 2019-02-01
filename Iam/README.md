# Creating IAM Policies with Terraform modules

This repo can be used to create multiple custome policies and also create multiple role using a single source file

## Important points

1) This module can be used to create custome policies.
2) It can also be used to create IAM Role by attaching custome policies with AWS provided policies
3) It can not be used to create Inline policies.

### Terraform code details 

1) Extensively used [interpolation](https://www.terraform.io/docs/configuration/interpolation.html) to do the multiple iteration.
2) Used ``` data "aws_caller_identity" "current" ``` to get AWS ID automaticaly. This will help us remove the hard coding of AWS ID in the code.

#### Example

Create a soure file whith following example for creating IAM custome policies and IAM role.

``` 
module "IAM_Role_test" {
  source                       = "./modules/IAM_ROLE"
  aws_iam_role_name            = "Iamroletest"
  aws_iam_role_description     = "to test the script"
  aws_iam_role_path            = "/"
  aws_iam_trusted_entity       = "assume-role-policy"
  aws_provided_policies        = ["AdministratorAccess", "PowerUserAccess"]
  aws_iam_custom_policies      = ["Route53-change-emr-master", "emr-ec2-config-01"]
} 
```
