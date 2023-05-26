# locals {
#   testgroup_patch_name  = "${var.testgroup_tags["Customer"]}-${var.testgroup_tags["Group"]}-${var.testgroup_tags["Product"]}"
#   testgroup_reboot_name = "${var.testgroup_tags["Customer"]}-${var.testgroup_tags["Group"]}-${var.testgroup_tags["Product"]}"
#   group1_patch_name     = "${var.group1_tags["Customer"]}-${var.group1_tags["Group"]}-${var.group1_tags["Product"]}"
#   group2_patch_name     = "${var.group2_tags["Customer"]}-${var.group2_tags["Group"]}-${var.group2_tags["Product"]}"
#   group1_reboot_name    = "${var.group1_tags["Customer"]}-${var.group1_tags["Group"]}-${var.group1_tags["Product"]}"
#   group2_reboot_name    = "${var.group2_tags["Customer"]}-${var.group2_tags["Group"]}-${var.group2_tags["Product"]}"
# }

# locals {
#   testgroup_patch_window_id  = module.testgroup-patch-window.maintenance-window-id
#   testgroup_reboot_window_id = module.testgroup-reboot-window.maintenance-window-id
#   group1_patch_window_id     = module.group1-patch-window.maintenance-window-id
#   group2_patch_window_id     = module.group2-patch-window.maintenance-window-id
#   group1_reboot_window_id    = module.group1-reboot-window.maintenance-window-id
#   group2_reboot_window_id    = module.group2-reboot-window.maintenance-window-id
# }
# variable "description" {
#   type        = string
#   description = "Default Description"
#   default     = "IMSMSO"
# }

# variable "testgroup_tags" {
#   type        = map(string)
#   description = "Resource Group Tags"
#   default = {
#     "Customer" = "IMSMSO",
#     "Group"    = "Test",
#     "Product"  = "intelepacs"
#   }
# }

variable "group1_tags" {
  type        = map(string)
  description = "Resource Group Tags"
  default = {
    "Customer" = "IMSMSO",
    "Group"    = "Group1",
    "Product"  = "intelepacs"
  }
}

# variable "group2_tags" {
#   type        = map(string)
#   description = "Resource Group Tags"
#   default = {
#     "Customer" = "IMSMSO",
#     "Group"    = "Group2",
#     "Product"  = "intelepacs"

#   }
# }

# ## Baseline Vars ##
# variable "baseline_id" {
#   type    = string
#   default = "pb-01a9db38931c877e3"
# }

# variable "approval_day_count" {
#   default = 7
# }