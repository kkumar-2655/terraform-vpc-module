#create vpc resource
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy    = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true


tags = merge(
  var.vpc_tags,
  local.common_tags,
  {
    Name = "${var.project}-${var.environment}"
  }
)
}   

#Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.igw_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-igw"
    }
  )
}

# create public subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.public_subnets_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
    }
  )
}

# create private subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.private_subnets_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}"
    }
  )
}

# create database subnet
resource "aws_subnet" "database" {
  count = length(var.database_subnets_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.database_subnets_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
    }
  )
}

#create eip 
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(
    var.eip_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-eip"
    }
  )
}

# create NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.nat_gateway_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-nat-gateway"
    }
  )

depends_on = [aws_internet_gateway.main]
}

# create route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.public_route_table_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-public"
    }
  )

}

# create route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.private_route_table_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-private"
    }
  )

}

# create route table for database subnet
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.database_route_table_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database"
    }
  )

}

# create route for public subnet
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# create route for private subnet
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# create route for database subnet
resource "aws_route" "database" {
  route_table_id         = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# associate public route table with public subnets
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidr)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
# associate private route table with private subnets
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
# associate database route table with database subnets
resource "aws_route_table_association" "database" {
  count = length(var.database_subnets_cidr)

  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}
