resource "aws_iam_role" "dlm_role" {
  name = "dlm-lifecycle-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "dlm.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "dlm_policy" {
  name = "dlm-lifecycle-policy"
  role = aws_iam_role.dlm_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ec2:CreateSnapshot", "ec2:DeleteSnapshot", "ec2:DescribeVolumes", "ec2:DescribeSnapshots"]
      Resource = "*"
    }]
  })
}
resource "aws_dlm_lifecycle_policy" "daily" {
  description        = "Daily snapshots for volumes tagged for Jenkins"
  execution_role_arn = aws_iam_role.dlm_role.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    target_tags = {
      (var.target_tag) = var.target_value
    }

    schedule {
      name = "daily"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
      }

      retain_rule {
        count = var.retain_count
      }
    }
  }
}

output "dlm_lifecycle_policy_id" {
  value = aws_dlm_lifecycle_policy.daily.id
}

