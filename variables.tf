variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "ami" {
  type        = string
  description = "Ubuntu 22.04 AMI ID for your region"
}

variable "ssh_key_name" {
  type        = string
  description = "Existing EC2 key pair name to attach to the instance"
}

variable "github_repo" {
  type        = string
  description = "HTTPS clone URL for the repo that contains docker-compose.yml"
}

variable "github_branch" {
  type    = string
  default = "main"
}

variable "jenkins_mount_point" {
  type    = string
  default = "/var/jenkins_home"
}

variable "ebs_size" {
  type    = number
  default = 20
}

variable "ebs_device_name" {
  type    = string
  default = "/dev/sdf"
}