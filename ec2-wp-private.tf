# WP Instances - EC2 Instances that will be created in VPC Private Subnets
resource "aws_instance" "wp-server1" {
  ami                         = "ami-026ebd4cfe2c043b2"
  instance_type               = "t3a.micro"
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [module.wp_private_sg.security_group_id]
  key_name                    = var.instance_keypair
  
  # root disk
  root_block_device {
    volume_size = var.ec2_volume_size
  }

  tags = {
    Name        = "wpserver1"
  }
}


resource "aws_instance" "wp-server2" {
  ami                         = "ami-026ebd4cfe2c043b2"
  instance_type               = "t3a.micro"
  subnet_id                   = module.vpc.private_subnets[1]
  vpc_security_group_ids      = [module.wp_private_sg.security_group_id]
  key_name                    = var.instance_keypair
  
  # root disk
  root_block_device {
    volume_size = var.ec2_volume_size
  }

  tags = {
    Name        = "wpserver2"
  }
}