variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "first_key"
}

variable "public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "C:\\Users\\Kiran\\.ssh\\id_ed25519.pub"
}
