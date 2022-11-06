variable "namespace" {}
variable "apps_name" {}

variable "origin_port" {
  type = number
  default = 8080
}

variable "f5xc_api_url" {       
  type = string
}

variable "f5xc_api_cert" {
  type = string
  default = ""
}

variable "f5xc_api_p12_file" {
  type = string
  default = ""
}

variable "f5xc_api_key" {
  type = string
  default = ""
}

variable "f5xc_api_ca_cert" {
  type = string
  default = ""
}

variable "f5xc_api_token" {
  type = string
  default = ""
}

variable "f5xc_tenant" {
  type = string
  default = ""
}

variable "site_token" {
  type        = string
}

variable "advertise_port" {
  type = number
  default = 80
}

variable "advertise_vip" {
  type = string
}

variable "advertise_sites" {
  type = list(string)
}

variable "origin_servers" {
  type = map(map(string))
}

variable "domains" {
  type = list(string)
}
