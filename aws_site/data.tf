data "ct_config" "workload" {
  content = templatefile("./templates/fcos_workload.yaml", { 
    cluster_name = var.site_name, 
    ssh_public_key = var.ssh_public_key,
  })
  strict = true
}

data "ct_config" "config" {
  content = templatefile("./templates/fcos_ce.yaml", { 
    site_token = var.site_token, 
    cluster_name = var.site_name, 
    ssh_public_key = var.ssh_public_key,
    site_label = var.site_label,
    custom_vip_cidr = var.custom_vip_cidr
  })
  strict = true
}

data "aws_ami" "latest-fcos" {
most_recent = true
owners = ["125523088429"] # Fedora CoreOS Owner

  filter {
      name   = "name"
      values = ["fedora-coreos-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}
