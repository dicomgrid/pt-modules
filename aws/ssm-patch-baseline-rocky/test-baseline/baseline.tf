#Global Linux PB. Dont copy this to other modules.
module "linux-pb" {
  source = "../../ssm-patch-baseline-rocky/"
  #source      = "git::ssh://git@github.com/dicomgrid/pt-modules.git//aws/ssm-patch-baseline-centos?ref=v0.1.0"
  name             = "RockyTest-PatchBaseline"
  description      = "${var.group1_tags["Customer"]}-Default${var.group1_tags["Product"]}PatchBaseline"
  rejected_patches = ["corosync*", "pacemaker*"]
}