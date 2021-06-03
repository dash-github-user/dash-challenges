locals {
  name = "${lower(var.environment)}-${lower(var.project)}-${lower(var.name)}"
}

resource "aws_ebs_volume" "ebs_vol" {
  availability_zone = var.availability_zone
  size              = var.size
  iops              = var.iops
  type              = var.type

  tags = {
    Name        = local.name
    project     = var.project
    environment = lower(var.environment)
    owner       = var.owner
    terraform   = "yes"
  }

}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.ebs_vol.id
  instance_id = var.instance_id
}