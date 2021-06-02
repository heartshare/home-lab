# Source the Cloud Init Config file
data "template_file" "cloud_init_deb10" {
  template = file("${path.module}/files/cloud_init_deb10.cloud_config.tpl")

  vars = {
    ssh_key  = var.ssh_key
    hostname = var.vm_hostname
    domain   = var.domain
    cloudinit_ansible_pull_branch = var.cloudinit_ansible_pull_branch
    cloudinit_ansible_pull_repo = var.cloudinit_ansible_pull_repo
    cloudinit_ansible_pull_inventory = var.cloudinit_ansible_pull_inventory
    cloudinit_ansible_pull_playbook = var.cloudinit_ansible_pull_playbook
    cloudinit_ansible_pull_extra_params = var.cloudinit_ansible_pull_extra_params
    cloudinit_github_user_ssh_pub = var.cloudinit_github_user_ssh_pub
  }
}

# Create a local copy of the file, to transfer to Proxmox
resource "local_file" "cloud_init_deb10" {
  content  = data.template_file.cloud_init_deb10.rendered
  filename = "${path.module}/files/user_data_cloud_init_deb10_${var.vm_hostname}.cfg"
}

# Transfer the file to the Proxmox Host
resource "null_resource" "cloud_init_deb10" {
  connection {
    type        = "ssh"
    user        = var.pm_user
    password    = var.pm_password
    host        = var.pm_ip
  }

  provisioner "file" {
    source      = local_file.cloud_init_deb10.filename
    destination = "/var/lib/vz/snippets/cloud_init_deb10_${var.vm_hostname}.yml"
  }
}

# Create the VM
resource "proxmox_vm_qemu" "vm" {
  ## Wait for the cloud-config file to exist

  depends_on = [
    null_resource.cloud_init_deb10
  ]

  additional_wait  = var.vm_additional_wait
  name        = var.vm_hostname
  desc        = var.description
  target_node = var.pm_target_node

  # Clone from debian-cloudinit template
  clone   = "debian-cloudinit"
  os_type = "cloud-init"

  # Cloud init options
  cicustom  = "user=local:snippets/cloud_init_deb10_${var.vm_hostname}.yml"
  ipconfig0 = "ip=${var.cloudinit_ip}/24,gw=${var.cloudinit_gw}"
  sshkeys   = var.ssh_key
  ciuser    = "user"
  cipassword = "user"


  # Resources
  cores  = var.vm_cores
  cpu    = var.vm_cpu
  vcpus  = var.vm_vcpu
  kvm    = var.vm_kvm
  memory = var.vm_memory
  agent  = var.vm_agent
  boot   = var.vm_boot
  guest_agent_ready_timeout = 60


  # Set the boot disk paramters
  bootdisk = var.bootdisk
  scsihw   = var.scsihw

  disk {
    size     = var.vm_disk_size
    type     = var.vm_disk_type
    storage  = var.vm_disk_storage
    format   = var.vm_disk_format
  }

  # Set the network
  network {
    model  = var.vm_network_model
    bridge = var.vm_network_bridge
  }

  # Ignore changes to the network
  ## MAC address is generated on every apply, causing
  ## TF to think this needs to be rebuilt on every apply
  lifecycle {
    ignore_changes = [
      network
    ]
  }
}