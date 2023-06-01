# 퍼블릭 서브넷 -> 라우팅 테이블 연결
resource "aws_route_table_association" "WorkShop-routing-public1" {
    subnet_id = aws_subnet.WorkShopPublicSubnet1.id
    route_table_id = aws_route_table.WorkShopPublicRoutingTable.id
}

resource "aws_route_table_association" "WorkShop-routing-public2" {
    subnet_id = aws_subnet.WorkShopPublicSubnet2.id
    route_table_id = aws_route_table.WorkShopPublicRoutingTable.id
}

# 프라이빗 서비넷 -> 라우팅 테이블 연결
resource "aws_route_table_association" "WorkShop-routing-private1" {
    subnet_id = aws_subnet.WorkShopPrivateSubnet1.id
    route_table_id = aws_route_table.WorkShopPrivateRoutingTable.id
}

resource "aws_route_table_association" "WorkShop-routing-private2" {
    subnet_id = aws_subnet.WorkShopPrivateSubnet2.id
    route_table_id = aws_route_table.WorkShopPrivateRoutingTable.id
}