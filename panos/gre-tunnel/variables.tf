variable "name" {}
variable "interface" {}
variable "local_address" {}
variable "peer_address" {}
variable "tunnel_interface" {}
variable "ttl" { default = null }
variable "copy_tos" { default = null }
variable "enable_keep_alive" { default = null }
variable "keep_alive_interval" { default = null }
variable "keep_alive_retry" { default = null }
variable "keep_alive_hold_timer" { default = null }
variable "disabled" { default = null }
