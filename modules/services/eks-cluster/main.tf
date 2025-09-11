#添加EKS集群的IAM ROLE
resource "aws_iam_role" "cluster" {
  name = "${var.name}-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role.json
}

data "aws_iam_policy_document" "cluster_assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.cluster.name
}

#获取默认VPC和子网信息，并为集群创建控制平面（control plane)
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name = "availability-zone"
    values = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d","us-east-1f"]
  }
}

resource "aws_eks_cluster" "cluster" {
  name = var.name
  role_arn = aws_iam_role.cluster.arn
  version = "1.29"

  
  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }

  depends_on = [ aws_iam_role_policy_attachment.AmazonEKSClusterPolicy ]
}

#添加EC2托管节点的IAM ROLE
resource "aws_iam_role" "node_group" {
  name = "${var.name}-node-group"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json
}

data "aws_iam_policy_document" "node_assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.node_group.name
}

#创建受管理节点本体
resource "aws_eks_node_group" "nodes" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = var.name
  node_role_arn = aws_iam_role.node_group.arn
  subnet_ids = data.aws_subnets.default.ids
  instance_types = var.instance_types

  scaling_config {
    min_size = var.min_size
    max_size = var.max_size
    desired_size = var.desired_size
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  ]
}
