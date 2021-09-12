# Terraform used for provisioning AWS EC2 instance
####################################################

# AMI Filter for Ubuntu Server 18.04
data "aws_ami" "ubuntu" {
  most_recent = true
  
  filter {
    name   = "name"
	  values = [var.instance_ami_name]
  }
  
  filter {
    name   = "virtualization-type"
	  values = [var.aws_virtualization_type]
  }
  
  owners = [var.owner_id] 
}

# AWS Instance
resource "aws_instance" "instance" {
  ami                         = data.aws_ami.ubuntu.id
  count                       = var.instance_count
  availability_zone           = var.availability_zone
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.aws_instance_type
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  subnet_id                   = aws_subnet.subnet.id
  key_name                    = var.key_pair
  
  root_block_device {
    delete_on_termination = true
	  encrypted             = false
	  volume_type           = var.root_device_type
	  volume_size           = var.root_device_size
  }
  
  # ignore ami changes when ami updates
  lifecycle {
    ignore_changes = [ami]
  }

  # tag name
  tags = {
    "Owner" = var.owner
    "Name"  = element(var.instance_tags, count.index)
  }
}

resource "aws_instance" "prod_instance" {
  ami                         = data.aws_ami.ubuntu.id
  availability_zone           = var.availability_zone
  instance_type               = var.aws_instance_type
  vpc_security_group_ids      = [aws_security_group.sg.id]
  key_name                    = var.key_pair
  
  root_block_device {
    delete_on_termination = true
	  encrypted             = false
	  volume_type           = var.root_device_type
	  volume_size           = var.root_device_size
  }
  
  # ignore ami changes when ami updates
  lifecycle {
    ignore_changes = [ami]
  }

  # tag name
  tags = {
    "Owner" = var.owner
    "Name"  = var.instance_tag
  }
}