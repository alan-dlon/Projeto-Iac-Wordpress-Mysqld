terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
}

# 1. Servidor do WordPress (Web)
resource "aws_instance" "wordpress" {
  ami           = "ami-0e5497a77ef21b5ac"
  instance_type = "t3.small"
  key_name      = "iac-alura2"

  tags = {
    Name = "WordPress-Web"
  }
}

# 2. Servidor do MySQL (Banco de Dados)
resource "aws_instance" "mysql" {
  ami           = "ami-0e5497a77ef21b5ac"
  instance_type = "t3.small"
  key_name      = "iac-alura2"

  tags = {
    Name = "MySQL-DB"
  }
}

# Exibir os IPs no terminal após o 'terraform apply'
output "wordpress_public_ip" {
  description = "IP Público do WordPress"
  value       = aws_instance.wordpress.public_ip
}

output "mysql_public_ip" {
  description = "IP Público do MySQL (para SSH)"
  value       = aws_instance.mysql.public_ip
}

output "mysql_private_ip" {
  description = "IP Privado do MySQL (para o WordPress conectar internamente)"
  value       = aws_instance.mysql.private_ip
}
