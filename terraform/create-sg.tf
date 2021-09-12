# Security Group for the AWS instances
resource "aws_security_group" "jenkins_sg" {
  name        = "${var.owner}-sg"
  description = "Web Security Group"

  vpc_id = aws_vpc.vpc.id

  ingress = [
  {
    description      = "Ingress rule for SSH" 
  	protocol         = var.sg_ingress_protocol
    from_port        = var.sg_ingress_ssh
	  to_port          = var.sg_ingress_ssh
	  cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false
  },
  {
    description      = "Ingress rule for HTTP"
	  protocol         = var.sg_ingress_protocol
    from_port        = var.sg_ingress_http
	  to_port          = var.sg_ingress_http
    cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false	
   },
   {
    description      = "Ingress rule for jenkins"
	  protocol         = var.sg_ingress_protocol
    from_port        = var.sg_ingress_http_jenkins
	  to_port          = var.sg_ingress_http_jenkins
    cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false	
   },
   {
    description      = "Ingress rule for jenkins slave"
	  protocol         = var.sg_ingress_protocol
    from_port        = var.sg_ingress_http_jenkins_jnlp
	  to_port          = var.sg_ingress_http_jenkins_jnlp
    cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false	
   },
   {
    description      = "Ingress rule for HTTPS"
	  protocol         = var.sg_ingress_protocol
    from_port        = var.sg_ingress_https
	  to_port          = var.sg_ingress_https
	  cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false
   }]
  
  
  egress = [{
    description      = "All traffic"
    protocol         = var.sg_egress_protocol
    from_port        = var.sg_egress_all
    to_port          = var.sg_egress_all
    cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false
  }]
}
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Web Security Group"

  ingress = [
  {
    description      = "Ingress rule for SSH" 
  	protocol         = var.sg_ingress_protocol
    from_port        = var.sg_ingress_ssh
	  to_port          = var.sg_ingress_ssh
	  cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false
  },
  {
    description      = "Ingress rule for HTTP"
	  protocol         = var.sg_ingress_protocol
    from_port        = var.sg_ingress_http
	  to_port          = var.sg_ingress_http
    cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false	
   },
   {
    description      = "Ingress rule for HTTPS"
	  protocol         = var.sg_ingress_protocol
    from_port        = var.sg_ingress_https
	  to_port          = var.sg_ingress_https
	  cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false
   }]
  
  
  egress = [{
    description      = "All traffic"
    protocol         = var.sg_egress_protocol
    from_port        = var.sg_egress_all
    to_port          = var.sg_egress_all
    cidr_blocks      = [var.sg_cidr_block]
	  ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
	  self             = false
  }]
}