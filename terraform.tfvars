vpc_cidr       = "172.16.0.0/16"
vpc_name       = "Test-VPC"
private_a_cidr = "172.16.0.0/24"
private_b_cidr = "172.16.1.0/24"
public_a_cidr  = "172.16.2.0/24"
public_b_cidr  = "172.16.3.0/24"
ec2_linux_specs = {
  "ami"           = "ami-0e001c9271cf7f3b9"
  "instance_type" = "t3.micro"
}

ec2_windows_specs = {
  "ami"           = "ami-0f9c44e98edf38a2b"
  "instance_type" = "t3.large"
}

ec2_aws_specs = {
  "ami"           = "ami-01b799c439fd5516a"
  "instance_type" = "t2.micro"
}

kms_key_id = "arn:aws:kms:us-east-1:059140706790:key/327ffd90-5edc-4c5c-944c-4afa41ba64d5"
