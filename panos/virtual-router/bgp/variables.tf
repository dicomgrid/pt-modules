### BGP Variables
variable "aggregate_med" { default = null }
variable "allow_redistribute_default_route" { default = null }
variable "always_compare_med" { default = null }
variable "as_format" { default = null }
variable "as_number" { default = null }
variable "bfd_profile" { default = null }
variable "confederation_member_as" { default = null }
variable "default_local_preference" { default = null }
variable "deterministic_med_comparison" { default = null }
variable "ecmp_multi_as" { default = null }
variable "enable_graceful_restart" { default = null }
variable "enforce_first_as" { default = null }
variable "install_route" { default = null }
variable "local_restart_time" { default = null }
variable "max_peer_restart_time" { default = null }
variable "reflector_cluster_id" { default = null }
variable "reject_default_route" { default = null }
variable "router_id" { default = null }
variable "stale_route_time" { default = null }
variable "virtual_router" { default = null }


### BGP Component Variables
variable "peer_groups" { default = {} }
variable "peers" { default = {} }
variable "redist_rules" { default = {} }
variable "import_rule_groups" { default = {} }
variable "export_rule_groups" { default = {} }
