resource "aws_instance" "bastion" {
  subnet_id                   = aws_subnet.public_a.id
  ami                         = data.aws_ami.amazon-2.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  key_name                    = "ghost-ec2-pool"

  iam_instance_profile = aws_iam_instance_profile.ghost-profile.name


  tags = {
    Name = "bastion"
  }
}