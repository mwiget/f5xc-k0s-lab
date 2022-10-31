resource "aws_subnet" "k0s_subnet" {
  vpc_id = var.vpc_id

  cidr_block        = var.subnet_cidr
  availability_zone = format("%s%s", var.aws_region, var.aws_az)

  tags = {
    Name = "${var.site_name}"
    Creator = var.owner_tag
  }
}

resource "aws_route_table_association" "k0s_route_table_association" {
  subnet_id      = aws_subnet.k0s_subnet.id
  route_table_id = var.route_table_id
}

resource "aws_instance" "ce" {
  ami                     = data.aws_ami.latest-fcos.id
  instance_type           = var.instance_type
  user_data               = data.ct_config.config.rendered
  vpc_security_group_ids  = [
    var.security_group_id,
  ]
  subnet_id               = aws_subnet.k0s_subnet.id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 40
  }

  tags = {
    Name    = "${var.site_name}-ce"
    Creator = var.owner_tag
  }
}

resource "aws_instance" "workload" {
  ami                     = data.aws_ami.latest-fcos.id
  instance_type           = "t3.micro"
  user_data               = data.ct_config.workload.rendered
  vpc_security_group_ids  = [
    var.security_group_id,
  ]
  subnet_id               = aws_subnet.k0s_subnet.id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 40
  }

  tags = {
    Name    = "${var.site_name}-wl"
    Creator = var.owner_tag
  }
}

module "site_wait_for_online" {
  depends_on     = [volterra_registration_approval.ce]
  source         = "../modules/f5xc/status/site"
  f5xc_namespace = "system"
  f5xc_api_token = var.f5xc_api_token
  f5xc_api_url   = var.f5xc_api_url
  f5xc_site_name = var.site_name
  f5xc_tenant    = var.f5xc_tenant
} 

resource "volterra_registration_approval" "ce" {
  depends_on    = [resource.aws_instance.ce]
  cluster_name  = var.site_name
  hostname      = "vp-manager-0"
  cluster_size  = 1
  retry = 30
  wait_time = 30
}

resource "volterra_site_state" "decommission_when_delete" {
  name       = var.site_name
  when       = "delete"
  state      = "DECOMMISSIONING"
  wait_time  = 120
  retry      = 5
  depends_on = [volterra_registration_approval.ce]
}

output "site_name" {
  value = var.site_name
}
output "ce_public_ip" {
  value = aws_instance.ce.public_ip
}
output "ce_private_ip" {
  value = aws_instance.ce.private_ip
}
output "workload_public_ip" {
  value = aws_instance.workload.public_ip
}
output "workload_private_ip" {
  value = aws_instance.workload.private_ip
}
