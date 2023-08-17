# Create Role for EKS Cluster
resource "aws_iam_role" "iam-role-eks" {
  name = "iam-role-eks"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam-role-eks.name
}

# Create EKS Cluster
resource "aws_eks_cluster" "devops-eks-cluster" {
  name     = "devops-eks-cluster"
  role_arn = aws_iam_role.iam-role-eks.arn

  vpc_config {
    subnet_ids = [
      for item in aws_subnet.tf_public_subnet : item.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  ]
}

# Create Role For EKS Node Group
resource "aws_iam_role" "iam-role-eks-node-group" {
  name = "iam-role-eks-node-group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam-role-eks-node-group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam-role-eks-node-group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam-role-eks-node-group.name
}

# Create EKS Node Group For EKS Cluster
resource "aws_eks_node_group" "devops-eks-node-group" {
  cluster_name    = aws_eks_cluster.devops-eks-cluster.name
  node_group_name = "devops-iam-role-eks-node-group"
  node_role_arn   = aws_iam_role.iam-role-eks-node-group.arn
  instance_types  = ["t2.micro"]
  subnet_ids = [
    for item in aws_subnet.tf_public_subnet : item.id
  ]

  scaling_config {
    desired_size = 7
    max_size     = 7
    min_size     = 7
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

output "eks-cluster-server-api" {
  value = aws_eks_cluster.devops-eks-cluster.endpoint
}
