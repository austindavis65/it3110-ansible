# ─────────────────────────────────────────────
#  EC2 Instance
# ─────────────────────────────────────────────
resource "aws_instance" "financial_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.financial_server_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name        = "${var.project_name}-root"
      Environment = var.environment
    }
  }

  tags = {
    Name        = "${var.project_name}-server"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# ─────────────────────────────────────────────
#  Additional 5 GiB EBS Volume (for partitioning)
# ─────────────────────────────────────────────
resource "aws_ebs_volume" "data_disk" {
  availability_zone = aws_instance.financial_server.availability_zone
  size              = 5
  type              = "gp3"
  encrypted         = true

  tags = {
    Name        = "${var.project_name}-data-disk"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# ─────────────────────────────────────────────
#  Attach EBS Volume → /dev/xvdf
# ─────────────────────────────────────────────
resource "aws_volume_attachment" "data_disk_attach" {
  device_name  = "/dev/xvdf"
  volume_id    = aws_ebs_volume.data_disk.id
  instance_id  = aws_instance.financial_server.id
  force_detach = false
}

# ─────────────────────────────────────────────
#  Security Group
# ─────────────────────────────────────────────
resource "aws_security_group" "financial_server_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for financial server"
  vpc_id      = var.vpc_id

  # SSH — restrict to your IP in production
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  # All outbound allowed
  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

