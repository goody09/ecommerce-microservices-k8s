module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                   = var.name
  cluster_version                = "1.30"
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    goody_node_1 = {
      min_size     = 1
      max_size     = 4
      desired_size = 1

      instance_types = ["t2.medium"]
    }
    goody_node_2 = {
      min_size     = 1
      max_size     = 4
      desired_size = 1

      instance_types = ["t2.medium"]
    }
  }

  enable_cluster_creator_admin_permissions = true
}
