variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for ALB"
  type        = string
}

variable "instance_id" {
  description = "EC2 instance ID"
  type        = string
}
