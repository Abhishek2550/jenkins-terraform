resource "aws_ebs_volume" "jenkins_data" {
  availability_zone = var.availability_zone
  size              = var.size_gb
  type              = "gp3"

  tags = merge(var.tags, {
    Name   = "jenkins-data"
    Backup = "true"
  })
}

output "volume_id" { value = aws_ebs_volume.jenkins_data.id }
output "volume_az" { value = aws_ebs_volume.jenkins_data.availability_zone }
