module "platform_namespace" {
  source         = "./namespace" #TODO: migrate to pt-terraform when pt-modules url available
  namespace_path = "platform"
}
module "deliveryautomation_namespace" {
  source         = "./namespace" #TODO: migrate to pt-terraform when pt-modules url available
  namespace_path = "deliveryautomation"
}