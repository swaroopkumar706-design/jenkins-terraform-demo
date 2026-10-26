variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "Valid AMI ID in the selected AWS region"
  type        = string
}

variable "subnet_id" {
  description = "Existing subnet ID"
  type        = string
}
