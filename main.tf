module "aws-vpc-region-a" {
  count           = 1
  source          = "./aws_vpc"
  vpc_name        = format("%s-aws-vpc-%d", var.project_prefix, count.index)
  vpc_cidr        = "10.64.0.0/22"
  owner_tag       = var.owner_tag
  providers       = {
    aws      = aws.eu-north-1
  }
}

module "aws-site-region-a" {
  count             = 2
  source            = "./aws_site"
  site_name         = format("%s-aws-r1-%d", var.project_prefix, count.index)
  instance_type     = "t3.xlarge"
  aws_region        = "eu-north-1"
  aws_az            = [ "a" , "b" ][count.index % 2]
  vpc_id            = module.aws-vpc-region-a[0].vpc.id
  route_table_id    = module.aws-vpc-region-a[0].route_table.id
  security_group_id = module.aws-vpc-region-a[0].security_group.id
  subnet_cidr       = format("10.64.%d.0/24", count.index % 256)
  bastion_cidr      = var.bastion_cidr
  ssh_public_key    = var.ssh_public_key
  site_label        = format("vsite: %s-k0s", var.project_prefix)
  f5xc_tenant       = var.f5xc_tenant
  f5xc_api_token    = var.f5xc_api_token
  f5xc_api_url      = var.f5xc_api_url
  site_token        = resource.volterra_token.token.id
  owner_tag         = var.owner_tag
  providers         = {
    volterra = volterra.default,
    aws      = aws.eu-north-1
  }
}

module "namespace" {
  source              = "./modules/f5xc/namespace"
  f5xc_namespace_name = format("%s-k0s-lab", var.project_prefix)
  providers           = {
    volterra = volterra.default
  }
}

module "virtual_site" {
  source                                = "./modules/f5xc/site/virtual"
  f5xc_namespace                        = "shared"
  f5xc_virtual_site_name                = format("%s-k0s-vsite", var.project_prefix)
  f5xc_virtual_site_type                = "CUSTOMER_EDGE"
  f5xc_virtual_site_selector_expression = [ format("vsite in (%s-k0s)", var.project_prefix) ]
  providers                             = {
    volterra = volterra.default
  }
}

module "smg" {
  source                           = "./modules/f5xc/site-mesh-group"
  f5xc_tenant                      = var.f5xc_tenant
  f5xc_namespace                   = "system"
  f5xc_virtual_site_name           = module.virtual_site.virtual-site["name"]
  f5xc_site_mesh_group_name        = format("%s-k0s-smg", var.project_prefix)
  f5xc_site_2_site_connection_type = "full_mesh"
  providers                        = {
    volterra = volterra.default
  }
}

resource "volterra_token" "token" {
  name      = format("%s-k0s-token", var.project_prefix)
  namespace = "system"
}

output "virtual-site" {
  value = module.virtual_site
}

output "namespace" {
  value = module.namespace
}

output "site-mesh-group" {
  value = module.smg
}

output "site-token" {
  value = resource.volterra_token.token
}

output "aws-vpc-region-a" {
  value = module.aws-vpc-region-a
}

output "aws-site-region-a" {
  value = module.aws-site-region-a
}