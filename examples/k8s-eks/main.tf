provider "aws" {
  region = "us-east-1"
}

module "eks_cluster" {
  source = "../../modules/services/eks-cluster"

  name           = "example-eks-cluster"
  min_size       = 1
  max_size       = 2
  desired_size   = 1
  instance_types = ["t3.small"]
}

provider "kubernetes" {
  host = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(
    module.eks_cluster.cluster_certificate_authority[0].data
  )
  token = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_name
}

resource "kubernetes_config_map_v1_data" "aws_auth" {
  provider = kubernetes

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  force = true # 允许覆盖由EKS自动生成的初始版本

  data = {
    # 将IAM角色的映射关系用yamlencode函数转换成YAML字符串
    "mapRoles" = yamlencode([
      {
        # 同样，您需要确认 'worker_node_role_arn' 是您模块的正确输出变量名
        rolearn  = module.eks_cluster.worker_node_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])
    # 将IAM用户的映射关系用yamlencode函数转换成YAML字符串
    "mapUsers" = yamlencode([
      {
        userarn  = "arn:aws:iam::81385381911:user/nuc" # 您的用户ARN
        username = "nuc"
        groups   = ["system:masters"]
      }
    ])
  }

  depends_on = [
    module.eks_cluster
  ]
}

module "simple_webapp" {
  source = "../../modules/services/k8s-app"

  name           = "simple-webapp"
  image          = "813835381911.dkr.ecr.us-east-1.amazonaws.com/simple-webapp:latest"
  replicas       = 2
  container_port = 5000

  environment_variables = {
    PROVIDER = "Terraform"
  }
  depends_on = [module.eks_cluster]
}
