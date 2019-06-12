# provider is used to specifiy the region in which you want to deploy the  ec2 instance.
provider "aws" {
  region             = "us-east-1"
}

# variable are use to pass the default values

variable "TAG" {
  description = "tag to be passed to the instance"
  default = "ec2"
}


resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket              = "optimizely-terraform-remote-state-terraform-deployment"
  acl                 = "private"
  count               = "${var.app_workspace}"
  versioning {
    enabled           = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    noncurrent_version_expiration {
      days = 30
    }
  }

  # This flag provides extra protection against the destruction of a given
  # resource. When this is set to true, any plan that includes a destroy of
  # this resource will return an error message.
  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name        = "${var.vpc_environment}"
  }

