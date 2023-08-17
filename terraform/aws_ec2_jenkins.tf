resource "aws_instance" "tf_ec2_jenkins" {
  ami                         = "ami-0a481e6d13af82399"
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.tf_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.tf_securify_group.id]
  subnet_id                   = aws_subnet.tf_public_subnet[0].id
  security_groups             = [aws_security_group.tf_securify_group.id]
  associate_public_ip_address = true
  user_data                   = file("set_up_jenkin.sh")

  tags = {
    Name = "tf_ec2_jenkins"
  }
}

output "jenkin_url" {
  value = "http://${aws_instance.tf_ec2_jenkins.public_ip}:8080"
}

output "ssh-script-for-ec2-jenkins" {
  value = "ssh -i tf_key_pair.pem ec2-user@${aws_instance.tf_ec2_jenkins.public_ip}"
}
