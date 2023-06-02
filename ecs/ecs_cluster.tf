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