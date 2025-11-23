module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ebs" {
  source            = "./modules/ebs"
  availability_zone = "${var.region}a"
  size_gb           = var.ebs_size
  tags              = { Environment = "dev" }
}

module "ec2" {
  source              = "./modules/ec2"
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = module.vpc.subnet_id
  security_group_id   = module.sg.security_group_id
  ssh_key_name        = var.ssh_key_name
  github_repo         = var.github_repo
  github_branch       = var.github_branch
  ebs_device_name     = var.ebs_device_name
  ebs_volume_id       = module.ebs.volume_id
  jenkins_mount_point = var.jenkins_mount_point
}

module "snapshots" {
  source = "./modules/snapshots"
}
