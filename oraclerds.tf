terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  secret_key = var.secret_key
  access_key = var.access_key
  # Configuration options
}

resource "aws_db_instance" "alexbd" {
  allocated_storage    = var.storage
  db_name              = "alexprod1"
  engine               = "mysql"
  engine_version       = var.engine_version
  instance_class       = "db.t3.micro"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

resource "aws_instance" "application_database_server" {
  ami               = "ami-0dfcb1ef8550277af"
  availability_zone = "us-east-1a"
  instance_type     = "t2.micro"
  key_name          = "Test"

  tags = {
    Name    = "application_database_server"
    Env     = "dev"
    Contact = "alex.obomese@bof.com"
  }
}
