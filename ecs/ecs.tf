# ECS Cluster 생성
resource "aws_ecs_cluster" "WorkshopECSCluster" {
    name = "ecs-workshop-cls"
    setting {
      name = "containerInsights"
      value = "enabled"
    }
}

# Capacity Provider -> AutoScailng 구성 시