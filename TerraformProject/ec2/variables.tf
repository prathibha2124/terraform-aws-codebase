variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for EC2"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}
