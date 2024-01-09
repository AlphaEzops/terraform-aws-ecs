locals {
  name_prefix = format("%s-%s", var.environment, var.name_prefix)
}


resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.nano"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.bastion_host.id]

  tags = {
    Name     = format("%s-bastion", local.name_prefix)
  }
}