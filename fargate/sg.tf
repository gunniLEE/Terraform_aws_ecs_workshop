# ALB Security Group
resource "aws_security_group" "alb-sg" {
    vpc_id = aws_vpc.WorkShopVPC.id
    name = "alb-sg"
    ingress {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    description = "allow http for alb"
}

# Fargate Service Security Group 
resource "aws_security_group" "ecs_svc_sg" {
    vpc_id = aws_vpc.WorkShopVPC.id
    name = "ecs-svc-sg"
    ingress {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        security_groups = [aws_security_group.alb-sg.id]
    }
    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
    description = "allow http for ecs fargate service"
}