variable "pm_ip" {
  default = ""
}

variable "pm_port" {
  default = "8006"
}

variable "pm_api_url" {
  default = "api2/json"
}

variable "pm_user" {
  default = "root"
}

variable "pm_domain" {
  default = "pam"
}

variable "pm_password" {
  default = ""
}

variable "pm_target_node" {
  default =  ""
}

variable "ssh_key" {
  default = ""
}

variable "domain" {
  default =  ""
}

variable "vm_hostname"{
  default = ""
}

variable "cloudinit_ip" {
  default = ""
}

variable "cloudinit_gw" {
  default = ""
}

variable "cloudinit_ansible_pull_branch" {
  default = "master"
}

variable "cloudinit_ansible_pull_repo" {
  default = ""
}

variable "cloudinit_ansible_pull_inventory" {
  default = ""
}

variable "cloudinit_ansible_pull_playbook" {
  default = ""
}

variable "cloudinit_ansible_pull_extra_params" {
  default = ""
}

variable "cloudinit_github_user_ssh_pub" {
  default = ""
}