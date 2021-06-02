module "servers1" {
    source = "./modules/"

    pm_user = "root"
    pm_password = var.pm_password
    pm_ip = var.pm_ip
    ssh_key = var.ssh_key
    domain =  var.domain
    vm_hostname = var.vm_hostname
    pm_target_node = var.pm_target_node
    cloudinit_ip = "192.168.1.100"
    cloudinit_gw = "192.168.1.1"
    cloudinit_ansible_pull_repo = "https://github.com/stiliajohny/home-lab"
    cloudinit_ansible_pull_inventory = "ansible/localhost_inventory"
    cloudinit_ansible_pull_playbook = "ansible/kubernetes.yaml"
    cloudinit_github_user_ssh_pub = var.cloudinit_github_user_ssh_pub
}

