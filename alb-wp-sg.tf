# Security Group for Application Load Balancer (ALB)
module "loadbalancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"

  name = "loadbalancer-sg"
  description = "Security Group with HTTPS open for entire Internet (IPv4 CIDR), egress ports are all open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  
  tags = local.common_tags

}