# Define an internet gateway for VPC
# - to allow internet access within this subnet of the VPC
####################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-igw"
  }
}

# Define a routing table 
####################################################

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    // subnet can access anywhere
    cidr_block = var.rt_cidr_block

    //this custom route table will use this gateway for public net
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-rt"
  }
}

# Define association betwen the subnet and routing table
####################################################

resource "aws_route_table_association" "rb_sbn_association"{
  subnet_id = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}