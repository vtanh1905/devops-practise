resource "tls_private_key" "tf_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf_key_pair" {
  key_name   = "tf_key_pair"
  public_key = tls_private_key.tf_private_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.tf_private_key.private_key_pem
  filename = "tf_key_pair.pem"
}
