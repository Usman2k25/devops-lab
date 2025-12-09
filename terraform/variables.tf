variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance (Amazon Linux 2)"
  type        = string
  default     = "ami-0453ec754f44f9a4a" # Amazon Linux 2 in us-east-1
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
  default     = "usman-deploy-key"
}
