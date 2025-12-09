terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Security Group
resource "aws_security_group" "flask_app_sg" {
  name        = "flask-app-security-group"
  description = "Security group for Flask application"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Flask App"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "flask-app-sg"
  }
}

# EC2 Instance
resource "aws_instance" "flask_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  
  security_groups = [aws_security_group.flask_app_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              
              # Pull and run the Docker container
              sudo docker pull usman966/devops-lab:latest
              sudo docker run -d -p 5000:5000 --name flask-app --restart unless-stopped usman966/devops-lab:latest
              EOF

  tags = {
    Name = "Flask-App-Server"
  }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.flask_app.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.flask_app.public_dns
}

output "application_url" {
  description = "URL to access the Flask application"
  value       = "http://${aws_instance.flask_app.public_ip}:5000"
}
