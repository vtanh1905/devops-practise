resource "aws_security_group" "tf_securify_group" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf_securify_group"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
