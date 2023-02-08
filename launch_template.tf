resource "aws_launch_template" "ghost" {
  name = "ghost"

  iam_instance_profile {
    arn = aws_iam_instance_profile.ghost-profile.arn
  }


  image_id = data.aws_ami.amazon-2.id

  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.ec2_pool.id]

  key_name = "ghost-ec2-pool"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ghost"
    }
  }

  user_data = filebase64("${path.module}/user_data -RDS.sh")
}