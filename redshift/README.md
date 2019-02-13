# This module is used to creat redshift cluster with access to S3 bucket

## example for how to use this module

```
module "Redshift_s3" {
  source                       = "./modules/redshift"
  aws_iam_role_name            = "RedshiftCopyUnload"
  aws_iam_role_description     = "IAM role for copy and upload"
  aws_iam_role_path            = "/"
  aws_iam_trusted_entity       = "readshift"
  aws_provided_policies        = ["AmazonAthenaFullAccess", "AmazonS3ReadOnlyAccess", "AWSGlueConsoleFullAccess"]
  unique_identifier            = "tf-redshift-cluster"
  name_database                = "my_sample_database"
  username_redshift            = "sample"
  password_redshift            = "Redshiftsample1"
  redshift_security_group      = "Redshift_security_group"
  redshift_vpc                 = "<vpc_id>"
  redshift_bucket              = "redshift_bucket"
}
```
