provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "kind-kind"
}

module "k8s-app" {
  source = "../../modules/services/k8s-app"

  name = "simple-web"
  image = "websample"
  replicas = 2
  container_port = 5000
}
