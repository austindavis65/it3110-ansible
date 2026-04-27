# ─────────────────────────────────────────────
#  Instance Outputs
# ─────────────────────────────────────────────
output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.financial_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the financial server"
  value       = aws_instance.financial_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the financial server"
  value       = aws_instance.financial_server.public_dns
}

output "availability_zone" {
  description = "Availability zone the instance is deployed in"
  value       = aws_instance.financial_server.availability_zone
}

# ─────────────────────────────────────────────
#  EBS Volume Outputs
# ─────────────────────────────────────────────
output "data_volume_id" {
  description = "ID of the attached 5 GiB data EBS volume"
  value       = aws_ebs_volume.data_disk.id
}

output "data_volume_device" {
  description = "Device name the volume is attached as"
  value       = aws_volume_attachment.data_disk_attach.device_name
}

# ─────────────────────────────────────────────
#  Security Group
# ─────────────────────────────────────────────
output "security_group_id" {
  description = "ID of the security group attached to the instance"
  value       = aws_security_group.financial_server_sg.id
}

# ─────────────────────────────────────────────
#  Ansible Inventory Helper
# ─────────────────────────────────────────────
output "ansible_inventory_entry" {
  description = "Ready-to-paste inventory line for your Ansible hosts file"
  value       = "financial_server ansible_host=${aws_instance.financial_server.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/${var.key_name}.pem"
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.financial_server.public_ip}"
}

