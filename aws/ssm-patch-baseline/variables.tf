variable "name" {default = "null"}
variable "patch_classifications" {default = ["Security", "Bugfix", "Recommended"]}
variable "description" { default = "null" }
variable "rejected_patches" { default = null }
variable "approved_patches" { default = null }
variable "operating_system" { default = "null" }
variable "approval_days" { default = 7 }
variable "enable_non_security" {default = true}
variable "compliance_levels" {
  type = list(object({
    
    compliance_level = string
    severity = list(string)
  }))

  default = [
      {
      compliance_level = "CRITICAL"
      severity = ["Critical", "Important"]
      },
      {
      compliance_level = "MEDIUM"
      severity = ["Moderate"]
      },
      {
      compliance_level = "LOW"
      severity = ["Low"]
      },
  ]
}

variable "source_repos" {
  type = list(object({
    name = string
    products = list(string)
    configuration = string
  }))
  default = [
    {
      name = "base"
      products = [
        "CentOS7.0",
        "CentOS7.1",
        "CentOS7.2",
        "CentOS7.3",
        "CentOS7.4",
        "CentOS7.5",
        "CentOS7.6",
        "CentOS7.7",
        "CentOS7.8",
        "CentOS7.9"
        ]
      configuration = <<EOF
[base]
name=CentOS-$releasever - Base
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra
baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
exclude=corosync pacemaker
EOF
    },
  ]
}
