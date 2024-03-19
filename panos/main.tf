module "bgp" {
    source = "./bgp"

    for_each = var.bgp_routers

    aggregate_med = var.aggregate_med
    allow_redistribute_default_route = var.allow_redistribute_default_route
    always_compare_med = var.always_compare_med
    as_format = var.as_format
    as_number = var.as_number
    bfd_profile = var.bfd_profile
    confederation_member_as = var.confederation_member_as
    default_local_preference = var.default_local_preference
    deterministic_med_comparison = var.deterministic_med_comparison
    ecmp_multi_as = var.ecmp_multi_as
    enable_graceful_restart = var.enable_graceful_restart
    enforce_first_as = var.enforce_first_as
    install_route = var.install_route
    local_restart_time = var.local_restart_time
    max_peer_restart_time = var.max_peer_restart_time
    reflector_cluster_id = var.reflector_cluster_id
    reject_default_route = var.reject_default_route
    router_id = var.router_id
    stale_route_time = var.stale_route_time
    virtual_router = var.virtual_router
}
