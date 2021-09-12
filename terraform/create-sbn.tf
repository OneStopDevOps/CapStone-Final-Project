# Defining a subnet for VPC
# - a subnet must be created inside the VPC with its unique CIDR block
####################################################

resource "aws_subnet" "subnet" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = var.sbn_cidr_block
  #map_customer_owned_ip_on_launch = var.sbn_public_ip
  availability_zone               = var.availability_zone

  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-sbn"
  }
}
