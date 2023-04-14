variable "all" {
  default = [
    {
      description = "All traffic"
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
    }
  ]
}
output "all" {
  value = var.all
}

variable "ambra_services" {
  default = [
    {
      description = "Services"
      from_port   = "8020"
      to_port     = "8021"
      protocol    = "tcp"
    },
    {
      description = "Watchdog"
      from_port   = "8080"
      to_port     = "8080"
      protocol    = "tcp"
    }
  ]
}
output "ambra_services" {
  value = var.ambra_services
}

variable "ambra_storage" {
  default = [
    {
      description = "HAproxy"
      from_port   = "4001"
      to_port     = "4001"
      protocol    = "tcp"
    },
    {
      description = "Storage"
      from_port   = "10080"
      to_port     = "10080"
      protocol    = "tcp"
    },
    {
      description = "JMX"
      from_port   = "10001"
      to_port     = "10001"
      protocol    = "tcp"
    },
    {
      description = "Web monitoring dashboard"
      from_port   = "10085"
      to_port     = "10085"
      protocol    = "tcp"
    }
  ]
}
output "ambra_storage" {
  value = var.ambra_storage
}

variable "ambra_transcoding" {
  default = [
    {
      description = "Transcoding"
      from_port   = "4001"
      to_port     = "4006"
      protocol    = "tcp"
    }
  ]
}
output "ambra_transcoding" {
  value = var.ambra_transcoding
}

variable "check_mk" {
  default = [
    {
      description = "Check_MK"
      from_port   = "6556"
      to_port     = "6556"
      protocol    = "tcp"
    }
  ]
}
output "check_mk" {
  value = var.check_mk
}

variable "efs" {
  default = [
    {
      description = "EFS"
      from_port   = "2049"
      to_port     = "2049"
      protocol    = "tcp"
    }
  ]
}
output "efs" {
  value = var.efs
}

variable "memcached" {
  default = [
    {
      description = "Memcached"
      from_port   = "11211"
      to_port     = "11211"
      protocol    = "tcp"
    }
  ]
}
output "memcached" {
  value = var.memcached
}

variable "mgmt" {
  type = list(map(any))
  default = [
    {
      description = "ICMP"
      from_port   = "-1"
      to_port     = "-1"
      protocol    = "icmp"
    },
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
    },
    {
      description = "RDP"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
    }
  ]
}
output "mgmt" {
  value = var.mgmt
}

variable "postgresql" {
  default = [
    {
      description = "Postgresql"
      from_port   = "5432"
      to_port     = "5432"
      protocol    = "tcp"
    }
  ]
}
output "postgresql" {
  value = var.postgresql
}

variable "redis" {
  default = [
    {
      description = "Redis"
      from_port   = "6379"
      to_port     = "6380"
      protocol    = "tcp"
    }
  ]
}
output "redis" {
  value = var.redis
}

variable "web" {
  type = list(map(any))
  default = [
    {
      description = "ICMP"
      from_port   = "-1"
      to_port     = "-1"
      protocol    = "icmp"
    },
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    },
  ]
}
output "web" {
  value = var.web
}

variable "tailscale_perf_test" {
  type = list(map(any))
  default = [
    {
      description = "ICMP"
      from_port   = "-1"
      to_port     = "-1"
      protocol    = "icmp"
    },
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
    },
  ]
}
output "tailscale_perf_test" {
  value = var.tailscale_perf_test
}