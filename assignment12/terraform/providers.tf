terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # ── Optional: Remote state in S3 ──────────────────
  # Uncomment and fill in to store state remotely.
  # Recommended for team environments.
  #
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "financial-server/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Project     = var.project_name
      Environment = var.environment
    }
  }
}

