# 퍼블릭 라우팅
resource "aws_route_table" "WorkShopPublicRoutingTable" {
    vpc_id = aws_vpc.WorkShopVPC.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.WorkShopInterNetGateway.id  # 인터넷게이트웨이 별칭 입력
    }
    tags = {
      Name = "workshop-pub-rt"
    }
}


# 프라이빗 라우팅
resource "aws_route_table" "WorkShopPrivateRoutingTable" {
    vpc_id = aws_vpc.WorkShopVPC.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.WorkShopNATGateway.id
    }
    tags = {
      Name = "workshop-prv-rt"
    }
}

## aws_route_table_association으로 서브넷에 연결 ---->