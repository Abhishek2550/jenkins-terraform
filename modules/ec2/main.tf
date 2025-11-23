data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ec2_role" {
  name               = "jenkins-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "jenkins-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.ssh_key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_size = 30
  }

  user_data = templatefile("${path.module}/user_data.tpl", {
    github_repo         = var.github_repo,
    github_branch       = var.github_branch,
    jenkins_mount_point = var.jenkins_mount_point,
    ebs_device_name     = var.ebs_device_name
  })

  tags = { Name = "jenkins-server" }
}

resource "aws_eip" "eip" {
  instance = aws_instance.jenkins.id
  domain   = "vpc"
}

resource "aws_volume_attachment" "attach" {
  device_name  = var.ebs_device_name
  volume_id    = var.ebs_volume_id
  instance_id  = aws_instance.jenkins.id
  force_detach = true
}

output "instance_id" { value = aws_instance.jenkins.id }
output "public_ip" { value = aws_eip.eip.public_ip }
output "volume_id" { value = var.ebs_volume_id }
