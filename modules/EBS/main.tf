data "aws_instance" "ubuntu_instance" {
  instance_id = var.instance_id
}

locals {
  root_block_device = flatten([for rbd in data.aws_instance.ubuntu_instance.root_block_device : rbd])[0]
  instance_name     = data.aws_instance.ubuntu_instance.tags["Name"]
}

resource "aws_ebs_snapshot" "ubuntu_volume_snapshot" {
  volume_id = local.root_block_device.volume_id
  tags = {
    Name        = "${local.instance_name} Volume Snapshot"
    Description = "Snapshot of the root volume of instance ${local.instance_name}"
  }
}

resource "aws_ebs_volume" "encrypted_volume" {
  availability_zone = data.aws_instance.ubuntu_instance.availability_zone
  snapshot_id       = aws_ebs_snapshot.ubuntu_volume_snapshot.id
  encrypted         = true
  kms_key_id        = "arn:aws:kms:us-east-1:059140706790:key/327ffd90-5edc-4c5c-944c-4afa41ba64d5"
  type              = "gp3"
  tags = {
    Name = "${local.instance_name} Encrypted Volume"
  }
}

resource "null_resource" "stop_instance" {
  provisioner "local-exec" {
    command = "aws ec2 stop-instances --instance-ids ${var.instance_id}"

  }
}

resource "null_resource" "wait_instance_stopped" {
  depends_on = [null_resource.stop_instance]
  provisioner "local-exec" {
    command = "aws ec2 wait instance-stopped --instance-ids ${var.instance_id}"
  }

}
resource "null_resource" "detach_volume" {
  depends_on = [null_resource.wait_instance_stopped]
  provisioner "local-exec" {
    command = "aws ec2 detach-volume --volume-id ${local.root_block_device.volume_id}"
  }
}

resource "null_resource" "attach_encrypted_volume" {
  depends_on = [null_resource.detach_volume]
  provisioner "local-exec" {
    command = "aws ec2 attach-volume --volume-id ${aws_ebs_volume.encrypted_volume.id} --instance-id ${var.instance_id} --device ${local.root_block_device.device_name}"
  }
}

resource "null_resource" "start_instance" {
  depends_on = [null_resource.attach_encrypted_volume]
  provisioner "local-exec" {
    command = "aws ec2 start-instances --instance-ids ${var.instance_id}"
  }
}


