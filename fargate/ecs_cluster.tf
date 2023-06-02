# ECS Cluster 생성
resource "aws_ecs_cluster" "WorkshopECSCluster" {
    name = "ecs-workshop-cls"
    setting {
      name = "containerInsights"
      value = "enabled"
    }
}

# Capacity Provider -> AutoScailng 구성 



# ECS Task Definition

## web-def
data "template_file" "web" {
  template = file("./templates/task-def.conf.json.tpl")
  vars = {
    awslogs-region     = "ap-southeast-1"
    awslogs-group      = "/ecs/web"
    aws_ecr_repository = aws_ecr_repository.WorkShopWebImageRepo.repository_url
    tag                = "latest"
    container_port     = 80
    host_port          = 80
    app_name           = "web-def"
  }
}

resource "aws_ecs_task_definition" "web" {
  family                   = "web-def"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.web.rendered
  tags = {
    Environment = "WORKSHOP"
    Application = "WEB"
  }
}

## cats-def
data "template_file" "cats" {
  template = file("./templates/task-def.conf.json.tpl")
  vars = {
    awslogs-region     = "ap-southeast-1"
    awslogs-group      = "/ecs/cats"
    aws_ecr_repository = aws_ecr_repository.WorkShopCatsImageRepo.repository_url
    tag                = "latest"
    container_port     = 80
    host_port          = 80
    app_name           = "cats-def"
  }
}

resource "aws_ecs_task_definition" "cats" {
  family                   = "cats-def"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.cats.rendered
  tags = {
    Environment = "WORKSHOP"
    Application = "CATS"
  }
}

## dogs-def
data "template_file" "dogs" {
  template = file("./templates/task-def.conf.json.tpl")
  vars = {
    awslogs-region     = "ap-southeast-1"
    awslogs-group      = "/ecs/dogs"
    aws_ecr_repository = aws_ecr_repository.WorkShopDogsImageRepo.repository_url
    tag                = "latest"
    container_port     = 80
    host_port          = 80
    app_name           = "dogs-def"
  }
}

resource "aws_ecs_task_definition" "dogs" {
  family                   = "dogs-def"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.dogs.rendered
  tags = {
    Environment = "WORKSHOP"
    Application = "DOGS"
  }
}

# ECS Service
## web service
resource "aws_ecs_service" "web-svc" {
    name              = "web-svc"
    cluster           = aws_ecs_cluster.WorkshopECSCluster.id
    task_definition   = aws_ecs_task_definition.web.arn   ## id is not work ?? -> test
    desired_count     = 2
    launch_type       = "FARGATE"

    network_configuration {
      security_groups     = [aws_security_group.ecs_svc_sg.id]
      subnets             = [aws_subnet.WorkShopPrivateSubnet1.id, aws_subnet.WorkShopPrivateSubnet2.id]
      assign_public_ip    = true
  }
    load_balancer {
      target_group_arn    = aws_lb_target_group.ecs-svc.arn
      container_name      = "web-def"
      container_port      = 80
    
  }
}

## cats service
resource "aws_ecs_service" "cats-svc" {
    name              = "cats-svc"
    cluster           = aws_ecs_cluster.WorkshopECSCluster.id
    task_definition   = aws_ecs_task_definition.cats.arn 
    desired_count     = 2
    launch_type       = "FARGATE"

    network_configuration {
      security_groups     = [aws_security_group.ecs_svc_sg.id]
      subnets             = [aws_subnet.WorkShopPrivateSubnet1.id, aws_subnet.WorkShopPrivateSubnet2.id]
      assign_public_ip    = true
  }
    load_balancer {
      target_group_arn    = aws_lb_target_group.ecs-svc.arn
      container_name      = "cats-def"
      container_port      = 80
    
  }
}

## dogs service
resource "aws_ecs_service" "dogs-svc" {
    name              = "dogs-svc"
    cluster           = aws_ecs_cluster.WorkshopECSCluster.id
    task_definition   = aws_ecs_task_definition.dogs.id
    desired_count     = 2
    launch_type       = "FARGATE"

    network_configuration {
      security_groups     = [aws_security_group.ecs_svc_sg.id]
      subnets             = [aws_subnet.WorkShopPrivateSubnet1.id, aws_subnet.WorkShopPrivateSubnet2.id]
      assign_public_ip    = true
  }
    load_balancer {
      target_group_arn    = aws_lb_target_group.ecs-svc.arn
      container_name      = "dogs-def"
      container_port      = 80
    
  }
}