variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"   
}

variable "project" {
    type       = string
}

variable "environment" {
    type        = string
}

variable "vpc_tags" {
    description = "A map of tags to assign to the VPC"
    type        = map(string)
    default     = {}
}

variable "igw_tags" {
    description = "A map of tags to assign to the Internet Gateway"
    type        = map(string)
    default     = {}
  
}

 variable "public_subnets_cidr" {
    description = "List of public subnet CIDR blocks"
    type        = list(string)
   
 }

 variable "public_subnets_tags" {
    description = "A map of tags to assign to the public subnets"
    type        = map(string)
    default     = {}
   
 }

 variable "private_subnets_cidr" {
    description = "List of private subnet CIDR blocks"
    type        = list(string)
   
 }

 variable "private_subnets_tags" {
    description = "A map of tags to assign to the private subnets"
    type        = map(string)
    default     = {}

 }

 variable "database_subnets_cidr" {
    description = "List of database subnet CIDR blocks"
    type        = list(string)
   
 }

 variable "database_subnets_tags" {
    description = "A map of tags to assign to the database subnets"
    type        = map(string)
    default     = {}

 }

 variable "eip_tags" {
    description = "A map of tags to assign to the EIP"
    type        = map(string)
    default     = {}
  }

  variable "nat_gateway_tags" {
    description = "A map of tags to assign to the NAT Gateway"
    type        = map(string)
    default     = {}
  }

  variable "public_route_table_tags" {
    description = "A map of tags to assign to the public route table"
    type        = map(string)
    default     = {}
  }

  variable "private_route_table_tags" {
    description = "A map of tags to assign to the private route table"
    type        = map(string)
    default     = {}
  }

  variable "database_route_table_tags" {
    description = "A map of tags to assign to the database route table"
    type        = map(string)
    default     = {}
  }

  variable "is_peering_required" {
    default    = false
    
  }
  variable "peering_tags" {
    description = "A map of tags to assign to the VPC peering connection"
    type        = map(string)
    default     = {}
  }