# Variables for AWS General Information
####################################################

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable availability_zone {
  description = "AWS availability zone"
  type        = string
  default     = "us-west-1a"
}

variable "owner_id" {
  description = "Configuration owner id"
  type        = string   
  default     = "099720109477"
}

variable "owner" {
  description = "Configuration owner"
  type        = string
  default     = "jenkins"
}

variable "instance_count" {
  description = "Numbers of AWS instance"
  type        = string
  default     = "2"
}

variable "instance_tags" {
  description = "Tags for each jenkins master and slave"
  type        = list
  default     = ["master","slave"]
}

variable "instance_tag" {
  description = "Tag for production node"
  type        = string
  default    = "prod"
}

variable "key_pair" {
  description = "SSH key pair used to connect to AWS EC2"
  type        = string
  default     = "aws_terraform"
}

# Variables for VPC
####################################################
  variable "vpc_cidr_block" {
    description = "CIDR block for VPC"
    type        = string
    default     = "10.0.0.0/16"
  }

  variable "vpc_enable_dns_support" {
    description = "Enable DNS support for VPC"
    type        = bool
    default     = true
  }
  
  variable "vpc_enable_dns_hostnames" {
    description = "Enable DNS hostnames for VPC"
    type        = bool
    default     = true
  }

  variable "vpc_enable_classiclink" {
    description = "Enable classiclink for VPC"
    type        = bool
    default     = false
  }

  variable "vpc_instance_tenancy" {
    description = "Instance tenancy setting for VPC"
    type        = string
    default     = "default"
  }

# Variables for Security Group
####################################################
variable "sg_ingress_protocol" {
  description = "Protocol used for the ingress rule"
  type        = string
  default     = "tcp"
}

variable "sg_ingress_ssh" {
  description = "Port used for the ingress rule for ssh"
  type        = string
  default     = "22"
}

variable "sg_ingress_http" {
  description = "Port used for the ingress rule for http"
  type        = string
  default     = "80"
}

variable "sg_ingress_http_jenkins" {
  description = "Port used for ingress rule for jenkins"
  type        = string
  default     = "8080"
}

variable "sg_ingress_app_port" {
  description = "Port used for ingresss rule for the inventory service"
  type        = string
  default     = "8081"
}

variable "sg_ingress_http_jenkins_jnlp" {
  description = "Port used for ingress rule for jenkins slave"
  type        = string
  default     = "9007"
} 

variable "sg_ingress_https" {
  description = "Port used for the ingress rule for https"
  type        = string
  default     = "443"
}

variable "sg_egress_protocol" {
  description = "Protocol used for egress rule"
  type        = string
  default     = "-1"
}

variable "sg_egress_all" {
  description = "Port used for egress rule"
  type        = string
  default     = "0"
}

variable "sg_cidr_block" {
  description = "CIDR block for the egress rule"
  type        = string
  default     = "0.0.0.0/0"
}

# Variables for Subnet
####################################################
variable "sbn_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "sbn_public_ip" {
  description = "Assign a public IP to all instances within this subnet"
  type        = bool
  default     = true
}

# Variables for Route Table
####################################################
variable "rt_cidr_block" {
  description = "CIDR block for the route table"
  type        = string
  default     = "0.0.0.0/0"
}

# Variables for AWS Instance
####################################################

variable "instance_ami_name" {
  description = "AWS Ami name"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20210415"
}

variable "aws_virtualization_type" {
  description = "Virtualization type of the instance"
  type        = string
  default     = "hvm"
}

variable "aws_instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.micro"
}

variable "root_device_type" {
  description = "Type of the root block device"
  type        = string
  default     = "gp2"
}

variable "root_device_size" {
  description = "Size of the root block device in GB"
  type        = string
  default     = "8"
}

variable "associate_public_ip_address" {
  description = "Enable associate public IP for instance"
  type        = bool
  default     = true
}

# Variables for AWS IAM
####################################################

variable "iam_role_name" {
  description = "Define the iam role name"
  type        = string
  default     = "cm_role"
}

variable "iam_role_policy_version" {
  description = "Define the iam role policy version number"
  type        = string
  default     = "2012-10-17"
}

variable "iam_role_policy_effect" {
  description = "Define the iam role policy effect property"
  type        = string
  default     = "Allow"
}

variable "iam_role_policy_action" {
  description = "Define the iam role policy action property"
  type        = string
  default     = "sts:AssumeRole"
}

variable "iam_role_policy_principal_type" {
  description = "Define the iam role policy principal type"
  type        = string
  default     = "Service"
} 

variable "iam_role_policy_principal_identifier" {
  description = "Define the iam role policy principal identifier"
  type        = string
  default     = "ec2.amazonaws.com"
}

variable "iam_policy_action" {
  description = "Define the iam policy action"
  type        = string
  default     = "ec2:*"
}

variable "iam_policy_effect" {
  description = "Define the iam policy effect property"
  type        = string
  default     = "Allow"
}

variable "iam_instance_profile" {
  description = "Define the iam instance profile name for EC2"
  type        = string
  default     = "cm_profile"
}

# Variables for EIP
####################################################

variable "eip_vpc" {
  description = "Is this EIP ties to VPC"
  type        = bool
  default     = true
}