# Defining an AWS VPC for Terraform
####################################################

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_classiclink   = var.vpc_enable_classiclink
  instance_tenancy     = var.vpc_instance_tenancy

  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-vpc"
  }
}

resource "aws_vpc" "jenkins-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_classiclink   = var.vpc_enable_classiclink
  instance_tenancy     = var.vpc_instance_tenancy

  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-vpc"
  }
}