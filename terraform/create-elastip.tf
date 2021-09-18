# Define the elastic IP address for each EC2 instance
####################################################

resource "aws_eip" "instance" {
  count                      = var.instance_count
  vpc                        = var.eip_vpc
  #instance                  = 
  #network_interface         = 
  #associate_with_private_ip = 
  #public_ipv4_pool          = 

  tags = {
    Name = element(var.instance_tags, count.index)
  }
}

resource "aws_eip" "production" {
  vpc                        = var.eip_vpc
  #instance                  = 
  #network_interface         = 
  #associate_with_private_ip = 
  #public_ipv4_pool          = 

  tags = {
    Name = "prod"
  }
}

resource "aws_eip_association" "eip_instance_assoc" {
  count         = var.instance_count
  instance_id   = aws_instance.instance[count.index].id
  allocation_id = aws_eip.instance[count.index].id
}

resource "aws_eip_association" "eip_prod_assoc" {
  instance_id   = aws_instance.prod_instance.id
  allocation_id = aws_eip.production.id
}