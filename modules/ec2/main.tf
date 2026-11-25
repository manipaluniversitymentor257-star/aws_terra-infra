
# Fetch the latest Ubuntu 24.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


# IAM role that EC2 instances will assume
resource "aws_iam_role" "app" {
  name = "${var.name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.name}-ec2-role"
  }
}

resource "aws_iam_role_policy" "ecr_read" {
  name = "${var.name}-ecr-read-policy"
  role = aws_iam_role.app.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken"
        ]

        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]

        Resource = var.ecr_repository_arn
      }
    ]
  })
}

# Attach permissions required for AWS Systems Manager
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance profile makes the IAM role available to EC2
resource "aws_iam_instance_profile" "app" {
  name = "${var.name}-ec2-profile"
  role = aws_iam_role.app.name
}

# Launch Template for Application EC2 Instances
resource "aws_launch_template" "app" {


  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.app_security_group_id
  ]




  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -euxo pipefail

    apt-get update -y
    apt-get install -y docker.io curl unzip

    systemctl enable docker
    systemctl start docker

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
      -o "/tmp/awscliv2.zip"

    unzip -q /tmp/awscliv2.zip -d /tmp
    /tmp/aws/install

    docker --version
    aws --version

    aws ecr get-login-password --region ${var.aws_region} \
      | docker login --username AWS --password-stdin ${var.ecr_repository_url}

    docker pull ${var.ecr_repository_url}:${var.image_tag}

    docker run -d \
      --name sudoku-game \
      --restart always \
      -p 8080:8080 \
      ${var.ecr_repository_url}:${var.image_tag}
  EOF
  )


  iam_instance_profile {
    name = aws_iam_instance_profile.app.name
  }

  # Enforce IMDSv2 for better instance metadata security
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # Encrypted root EBS volume
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = 8
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name}-app-instance"
      Tier = "Application"
    }
  }

  update_default_version = true
}

# Auto Scaling Group for Application Instances
resource "aws_autoscaling_group" "app" {
  name = "${var.name}-app-asg"

  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size

  vpc_zone_identifier = var.app_subnet_ids
  target_group_arns   = var.target_group_arns
  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
      max_healthy_percentage = 150
      instance_warmup        = 300
    }


  }

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.name}-app-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Tier"
    value               = "Application"
    propagate_at_launch = true
  }
}