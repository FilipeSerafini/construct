# Configuração do provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Criação de uma VPC
resource "aws_vpc" "seller_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "SellerVPC"
  }
}

# Criação de sub-redes
resource "aws_subnet" "seller_subnet_a" {
  vpc_id            = aws_vpc.seller_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "SellerSubnetA"
  }
}

resource "aws_subnet" "seller_subnet_b" {
  vpc_id            = aws_vpc.seller_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "SellerSubnetB"
  }
}

# Criação de um grupo de sub-rede para o RDS
resource "aws_db_subnet_group" "seller_subnet_group" {
  name       = "seller-subnet-group"
  subnet_ids = [aws_subnet.seller_subnet_a.id, aws_subnet.seller_subnet_b.id]

  tags = {
    Name = "SellerSubnetGroup"
  }
}

# Criação de um banco de dados RDS
resource "aws_db_instance" "seller_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.32"  # Alterado para uma versão suportada
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "password123"
  db_subnet_group_name = aws_db_subnet_group.seller_subnet_group.name
  skip_final_snapshot  = true

  tags = {
    Name = "SellerDB"
  }
}

# Criação de uma instância EC2
resource "aws_instance" "seller_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.seller_subnet_a.id

  tags = {
    Name = "SellerInstance"
  }
}

# Criação de um bucket S3
resource "aws_s3_bucket" "seller_bucket" {
  bucket = "seller-bucket-exemplo-terraform"

  tags = {
    Name = "SellerBucket"
  }
}
