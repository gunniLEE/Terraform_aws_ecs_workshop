resource "aws_lb" "ecs-ext-alb" {
    name = "workshop-ecs-ext-alb"
    subnets = [ aws_subnet.WorkShopPublicSubnet1.id, aws_subnet.WorkShopPublicSubnet2.id ]
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb-sg.id]   
}

resource "aws_lb_listener" "http_forward" {
  load_balancer_arn = aws_lb.ecs-ext-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs-svc.arn

  }
}

resource "aws_lb_target_group" "ecs-svc" {
  name        = "ecs-service-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.WorkShopVPC.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}