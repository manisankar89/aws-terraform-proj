output "instance_public_ips" {
  description = "Public IPs of created instances"
  value = { for k, inst in aws_instance.ec2 : k => inst.public_ip }
}

output "security_group_ids" {
  description = "IDs of the created security groups"
  value = { for k, sg in aws_security_group.sg : k => sg.id }
}
