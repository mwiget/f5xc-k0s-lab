terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.14"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }

    ct = {
      source  = "poseidon/ct"
      version = ">= 0.11.0"
    }
  }
}
