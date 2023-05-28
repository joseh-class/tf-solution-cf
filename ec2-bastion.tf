# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
resource "aws_instance" "windows-bastion" {
  ami                         = "ami-0ab05a04b66a879af"
  instance_type               = "t3a.medium"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.public_bastion_sg.security_group_id]
  key_name                    = var.instance_keypair
  
  # root disk
  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "bastion1"
  }
}

resource "aws_eip" "bastion-eip" {
  instance = aws_instance.windows-bastion.id
  vpc = true
}