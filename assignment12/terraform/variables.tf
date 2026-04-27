# ─────────────────────────────────────────────
#  Project & Environment
# ─────────────────────────────────────────────
variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "financial-server"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "prod"
}

# ─────────────────────────────────────────────
#  AWS Region
# ─────────────────────────────────────────────
variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

# ─────────────────────────────────────────────
#  Networking
# ─────────────────────────────────────────────
variable "vpc_id" {
  description = "ID of the VPC to deploy into"
  type        = string
}

variable "subnet_id" {
  description = "ID of the public subnet to place the instance in"
  type        = string
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed to SSH to the server. Restrict to your IP in production."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# ─────────────────────────────────────────────
#  EC2
# ─────────────────────────────────────────────
variable "ami_id" {
  description = "AMI ID for Ubuntu 22.04 LTS (region-specific)"
  type        = string
  # Ubuntu 22.04 LTS us-east-1 — update per region
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
}

