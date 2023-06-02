# web, cats, dogs 이미지 레포지토리 생성
resource "aws_ecr_repository" "WorkShopWebImageRepo" {
    name = "web"
}

resource "aws_ecr_repository" "WorkShopCatsImageRepo" {
    name = "cats"
}

resource "aws_ecr_repository" "WorkShopDogsImageRepo" {
    name = "dogs"
}