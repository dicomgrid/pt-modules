variable "dx_gateway_id" {
    type = string
    description = "The ID of the Direct Connect gateway to associate with the vpg or tgw"
}

variable "allowed_prefixes" {
    type = list(string)
    description = "The route prefixes to advertise to the Direct Connect gateway"
}

variable "associated_gateway_id" {
    type = string
    description = "The ID of the VGW or TGW to associate with the Direct Connect gateway"
}