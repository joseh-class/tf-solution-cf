# Terraform AWS Application Load Balancer (ALB)
resource "aws_lb_target_group" "wp-server1" {
  name       = "wp-server1"
  port       = 8080
  protocol   = "HTTP"
  vpc_id     = module.vpc.vpc_id
  slow_start = 0

  load_balancing_algorithm_type = "round_robin"

  stickiness {
    enabled = false
    type    = "lb_cookie"
  }

  health_check {
    enabled             = true
    port                = 8081
    interval            = 30
    protocol            = "HTTP"
    path                = "/health"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "wp-server1" {
  for_each = aws_instance.wp-server1

  target_group_arn = aws_lb_target_group.wp-server1.arn
  target_id        = each.value.id
  port             = 8080
}

resource "aws_lb" "my_prod_alb" {
  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.loadbalancer_sg.security_group_id]
}
resource "aws_lb_listener" "wp-server1" {
  load_balancer_arn = aws_lb.my_prod_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wp-server1.arn
  }
}


