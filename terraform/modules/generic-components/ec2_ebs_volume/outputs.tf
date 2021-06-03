output "name" {
  value = local.name
}

output "volume_id" {
   value = "${aws_ebs_volume.ebs_vol.id}"
}
