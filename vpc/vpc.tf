# VPC  구성
resource "aws_vpc" "WorkShopVPC" {
    cidr_block = "10.90.0.0/16"
    enable_dns_hostnames = true
    tags = {
      Name = "workshop_vpc"
    }
}

# 서브넷 구성
## 퍼블릭 서브넷
resource "aws_subnet" "WorkShopPublicSubnet1" {
    vpc_id = aws_vpc.WorkShopVPC.id
    cidr_block = "10.90.1.0/24"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = true   # 퍼블릭 IP 자동 부여 설정
    tags = {
      Name = "workshop-pub-sub1"
    }
}

resource "aws_subnet" "WorkShopPublicSubnet2" {
    vpc_id = aws_vpc.WorkShopVPC.id
    cidr_block = "10.90.2.0/24"
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = true
    tags = {
      Name = "workshop-pub-sub2"
    }
}

## 프라이빗 서브넷
resource "aws_subnet" "WorkShopPrivateSubnet1" {
    vpc_id = aws_vpc.WorkShopVPC.id
    cidr_block = "10.90.101.0/24"
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = false   # 퍼블릭 IP 부여 X
    tags = {
      Name = "workshop-prv-sub1"
    }
}

resource "aws_subnet" "WorkShopPrivateSubnet2" {
    vpc_id = aws_vpc.WorkShopVPC.id
    cidr_block = "10.90.102.0/24"
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = false
    tags = {
      Name = "workshop-prv-sub2"
    }
}