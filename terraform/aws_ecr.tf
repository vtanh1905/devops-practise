resource "aws_ecr_repository" "tf_ecr" {
  count                = length(var.ecr_names)
  name                 = var.ecr_names[count.index]
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_url" {
  value = {
    for item in aws_ecr_repository.tf_ecr : item.name => item.repository_url
  }
}
