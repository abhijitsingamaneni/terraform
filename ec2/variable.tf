# variable are use to pass the default values
variable "TAG" {
  description                       = "tag to be passed to the instance"
}

variable "type" {
  description                       = "type of ec2 instance"
}

variable "security_groups" {
  description                       = "Security groups that needs to be attached to the instance"
}

variable "iam_role" {
  description                       = "IAM instance profile the need to added to instance"
}
variable "key_pair_name" {
  description                       = "Key pair that need to be attached to instance"
}
variable "subnet_id" {
  description                       = "subnet to spin up the instance"
}
variable "monitoring" {
  description                       = "If true, the launched EC2 instance will have detailed monitoring enabled"
}

variable "associate_public_ip_address" {
  description                       = "If true, the EC2 instance will have associated public IP address"
}

variable "availability_zone" {
  description                       = "availability zone in which ebs volume should reside"
}

variable "ebs_size" {
  description                       = "size of the ebs volume"
}

variable "ebs_name" {
  description                       = "name of the ebs volume"
}
variable "ebs_iops" {
  description                       = "iops for the ebs volume"
}
