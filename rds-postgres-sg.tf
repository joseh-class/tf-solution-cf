# Security Group for RDS Instance
module "rds_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"

  name = "rds-sg"
  description = "Access to Postgres for entire VPC CIDR Block"
  vpc_id = module.vpc.vpc_id

  # Ingress Rule
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Postgres access within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}