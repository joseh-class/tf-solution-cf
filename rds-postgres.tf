resource "aws_db_instance" "rds_postgres" {
  identifier             = "rds-postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "11.20"
  username               = "test"
  password               = var.db_password
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [module.rds_sg.security_group_id]
  skip_final_snapshot    = true
}

resource "aws_db_parameter_group" "rds_postgres" {
  name   = "rds-postgres"
  family = "postgres11"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}