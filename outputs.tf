output "jenkins_public_ip" {
  description = "Public IP of Jenkins server (Elastic IP)"
  value       = module.ec2.public_ip
}

output "jenkins_instance_id" {
  description = "EC2 instance id running Jenkins"
  value       = module.ec2.instance_id
}

output "jenkins_ebs_volume_id" {
  description = "EBS volume id for Jenkins data"
  value       = module.ebs.volume_id
}

output "dlm_policy_id" {
  description = "DLM lifecycle policy id"
  value       = module.snapshots.dlm_lifecycle_policy_id
}
