locals {
  name = "${lower(var.environment)}-${lower(var.project)}-${lower(var.name)}"
}

resource "aws_network_interface" "ec2_eni" {
  subnet_id       = var.subnet_id
  security_groups = var.security_groups

  private_ips = var.private_ips

  tags = {
    Name        = local.name
    project     = var.project
    environment = lower(var.environment)
    owner       = var.owner
    terraform   = "yes"
  }
}

resource "aws_network_interface" "ec2_eni2" {
  subnet_id       = var.subnet_id2
  security_groups = var.security_groups2

  private_ips = var.private_ips

  tags = {
    Name        = local.name
    project     = var.project
    environment = lower(var.environment)
    owner       = var.owner
    terraform   = "yes"
  }
}

resource "aws_instance" "ec2_instance" {
  #count = "${var.number_of_instances}"
  ami                  = var.image_id
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_instance_profile

  key_name = var.key_name
  #vpc_security_group_ids      = var.security_groups
  #subnet_id                   = var.subnet_id
  #associate_public_ip_address = var.static_nic ? null : var.associate_public_ip
  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized
  user_data               = var.user_data
  monitoring              = var.detailed_monitoring_enabled

  availability_zone = var.availability_zone
  
  # credit_specification {
  #     cpu_credits = "${var.cpu_credits}"
  # }

  volume_tags = {
    Name        = local.name
    environment = lower(var.environment)
    project     = var.project
    owner       = var.owner
    terraform   = "yes"
  }

  root_block_device {
    volume_size = var.root_ebs_size
    volume_type = var.root_ebs_type
  }

  network_interface {
    delete_on_termination = var.delete_nic_on_termination
    network_interface_id  = aws_network_interface.ec2_eni.id
    device_index          = 0
  }

  network_interface {
    delete_on_termination = var.delete_nic_on_termination
    network_interface_id  = aws_network_interface.ec2_eni2.id
    device_index          = 1
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  tags = {
    Name             = local.name
    project          = var.project
    owner            = var.owner
    environment      = lower(var.environment)
    function         = lower(var.function)
    monitoring_group = "non-asg"
    monitor_memory   = lower(var.monitor_memory)
    terraform        = "yes"
  }

  lifecycle {
    ignore_changes = [
      tags,
      user_data,
      # ami,
      ebs_block_device,
      ephemeral_block_device
    ]
  }

  provisioner "local-exec" {
    working_dir = "../../ansible"
    command     = var.local_exec_command
  }
}
