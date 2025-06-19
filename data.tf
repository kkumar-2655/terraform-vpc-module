data "aws_availability_zones" "available" {
  state = "available"
}
 
data "aws_vpc" "default" {
  # This data source is used to fetch the default VPC in the region.
  default = true
}

data "aws_route_table" "main" {
  # This data source is used to fetch the main route table of the default VPC.
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

/* output "azs_info" {
  value = data.aws_availability_zones.available
} */