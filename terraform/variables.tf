variable "region" {
  default = "ap-southeast-1"
}

variable "region_zone" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "access_key" {
  type = string
  sensitive = true
  # default = ""
}

variable "secret_key" {
  type = string
  sensitive = true
  # default = ""
}

variable "vpc_cidr_block" {
  default = "10.1.0.0/16"
}

variable "subnet_cidr_block" {
  type    = list(string)
  default = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
}

variable "ecr_names" {
  type    = list(string)
  default = ["frontend", "backend"]
}
