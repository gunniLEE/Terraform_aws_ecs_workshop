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
data "template_file" "web" {
  template = file("./templates/web-def.conf.json.tpl")
  vars = {
    awslogs-region     = "ap-southeast-1"
    awslogs-group      = "ecs-web"
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
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.web.rendered
  tags = {
    Environment = "WORKSHOP"
    Application = "WEB"
  }
}
