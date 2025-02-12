terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.59.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}


#data "aws_vpc" "default" {
  #default = true
#}


resource "aws_security_group" "k3s-16-ger" {
  name        = "k3s-16-ger"
  description = "Allow all inbound traffic"
  #vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# master node
resource "aws_instance" "master" {

  ami                    = var.image_id   #Ubuntu Server 22.04 
  instance_type          = "t3a.medium"
  vpc_security_group_ids = [aws_security_group.k3s-16-ger.id] #[aws_security_group.k3s_server.id]
  #key_name = k3s-new
  user_data = base64encode(templatefile("${path.module}/server-userdata.tmpl", {
    token = random_password.k3s_cluster_secret.result
  }))
  tags = {
    Name = "server-node"
  }
}

resource "aws_instance" "worker" {
  depends_on             = [ aws_instance.master ]
  for_each               = toset(["worker-1"])
  ami                    = var.image_id #Ubuntu Server 22.04 
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.k3s-16-ger.id] #[aws_security_group.k3s_agent.id]
  #key_name               = k3s-new
  user_data = base64encode(templatefile("${path.module}/agent-userdata.tmpl", {
    host  = aws_instance.master.private_ip,
    token = random_password.k3s_cluster_secret.result
  }))
  tags = {

    Name = "worker-node"
  }
}