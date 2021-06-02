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

variable "vm_additional_wait"{
  default = "5"
}

variable "vm_hostname"{
  default = ""
}

variable "description" {
  default = "Created with Terraform"
}

variable "vm_memory"{
  default = "1024"
}

variable "vm_cores"{
  default = "1"
}

variable "vm_cpu"{
  default = "host"
}

variable "vm_vcpu"{
  default = 0
}

variable "vm_kvm"{
  default = true
}

variable "vm_agent"{
  default = 1
}

variable "vm_boot"{
  default = "cdn"
}

variable "bootdisk"{
  default = "scsi0"
}

variable "scsihw"{
  default = "virtio-scsi-pci"
}

variable "vm_disk_size"{
  default = "20G"
}

variable "vm_disk_type"{
  default = "scsi"
}

variable "vm_disk_storage"{
  default = "local-lvm"
}

variable "vm_disk_format"{
  default = "vmdk"
}

variable "vm_network_model"{
  default = "virtio"
}

variable "vm_network_bridge"{
  default = "vmbr0"
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