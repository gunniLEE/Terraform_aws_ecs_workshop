# 인터넷게이트웨이 생성 후 VPC 연결
resource "aws_internet_gateway" "WorkShopInterNetGateway" {
    vpc_id = aws_vpc.WorkShopVPC.id
    tags = {
      Name = "workshop-igw"
    }
}

# NAT 게이트웨이가 사용할 Elastic IP 생성
resource "aws_eip" "WorkShopElasticIPForNAT" {
  vpc = true
  tags = {
    Name = "workshop-nat-eip"
  }
}

# NAT게이트웨이 생성 후 퍼블릿 서브넷 연결
resource "aws_nat_gateway" "WorkShopNATGateway" {
  subnet_id = aws_subnet.WorkShopPublicSubnet1.id
  allocation_id = aws_eip.WorkShopElasticIPForNAT.id  # EIP 연결
  tags = {
    Name = "workshop-nat-gw"
  }
}
