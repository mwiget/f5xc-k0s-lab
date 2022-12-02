variable "site_name" {
  type        = string
}

variable "aws_region" {
  type        = string
}

variable "aws_az" {
  type        = string
}

variable "internet_gateway_id" {
  type        = string
  default     = ""
}

variable "route_table_id" {
  type        = string
  default     = ""
}

variable "vpc_id" {
  type        = string
  default     = ""
}

variable "security_group_id" {
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  type        = string
  default     = ""
}

variable "subnet_cidr" {
  type        = string
}

variable "custom_vip_cidr" {
  type        = string
}

variable "site_label" {
  type        = string
  default     = ""
}

variable "custom_tags" {
  type        = map(string)
  default     = {}
}

variable "f5xc_tenant" {
  type        = string
}

variable "f5xc_api_p12_file" {
  type = string
  default = ""
}

variable "site_token" {
  type        = string
}

variable "instance_type" {
  type        = string
  default     = "t3.xlarge"
}

variable "ssh_public_key" {
  type        = string
}

variable "owner_tag" {
  type        = string
  default     = "m.wiget@f5.com"
}

variable "bastion_cidr" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_token" {
  type = string
  default = ""
}

variable "ver_image" {
  type    = map(string)
  default = {
    ca-central-1   = "ami-077bb9c847c6d9ef7"
    af-south-1     = "ami-05d60209ebad1f70c"
    ap-east-1      = "ami-0b9cab48b17de8415"
    ap-northeast-2 = "ami-0c548676e9a27ce83"
    ap-southeast-2 = "ami-00c8b3cc35d782bf7"
    ap-south-1     = "ami-01a1a13f752b02d59"
    ap-northeast-1 = "ami-03297d670703981c9"
    ap-southeast-1 = "ami-05b28eabaf624a6bf"
    eu-central-1   = "ami-0e99cef1d8e41d9e1"
    eu-west-1      = "ami-09cf2c94b0d2ca355"
    eu-west-3      = "ami-03175b50db858bc6b"
    eu-south-1     = "ami-07386e2285d5dff8a"
    eu-north-1     = "ami-0366c929eb2ac407b"    # updated
    #eu-north-1     = "ami-048577c3054929b99"
    eu-west-2      = "ami-094389688d488aeaa"
    me-south-1     = "ami-031a36a354ddadff7"
    sa-east-1      = "ami-0c5498aa41af80bfd"
    us-east-1      = "ami-0fa4728603d6f753c"
    us-east-2      = "ami-0eadac5d175627120"
    us-west-1      = "ami-0da9d480ee4009846"
    us-west-2      = "ami-0b0adddceaf57d93d"
  }
}

