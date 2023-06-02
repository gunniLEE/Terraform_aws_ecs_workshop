# CloudWatch Log Group
## web log group
resource "aws_cloudwatch_log_group" "web" {
    name = "/ecs/web"
    retention_in_days = "30"

    tags = {
        Environment = "WORKSHOP"
        Application = "WEB"
    }
}

## cats log group
resource "aws_cloudwatch_log_group" "cats" {
    name = "/ecs/cats"
    retention_in_days = "30"

    tags = {
        Environment = "WORKSHOP"
        Application = "cats"
    }
}

## dogs log group
 resource "aws_cloudwatch_log_group" "dogs" {
    name = "/ecs/dogs"
    retention_in_days = "30"

    tags = {
        Environment = "WORKSHOP"
        Application = "dogs"
    }
}