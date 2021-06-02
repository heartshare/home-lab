#cloud-config

output: { all: "| tee -a /var/log/cloud-init-output.log" }

package_update: true
package_upgrade: true

# APT fails to acquire GPG keys if package dirmngr is missing
bootcmd:
  - [ cloud-init-per, once, dirmngr-aptupdate, apt-get, update ]
  - [ cloud-init-per, once, dirmngr-aptinstall, apt-get, install, dirmngr, -y ]
  - [ cloud-init-per, once, dirmngr-aptinstall, apt-get, install, gnupg2, -y ]
  - [ cloud-init-per, once, dirmngr-aptinstall, apt-get, install, ansible, -y ]



runcmd:
  - /usr/bin/ansible-pull -C ${cloudinit_ansible_pull_branch} --sleep 15 -U "${cloudinit_ansible_pull_repo}" -i ${cloudinit_ansible_pull_inventory} ${cloudinit_ansible_pull_playbook} --limit 127.0.0.1 ${cloudinit_ansible_pull_extra_params}
  - curl -s  https://github.com/${cloudinit_github_user_ssh_pub}.keys > /root/.ssh/authorized_keys
  - curl -s  https://github.com/${cloudinit_github_user_ssh_pub}.keys > /home/debian/.ssh/authorized_keys
  - curl -s  https://github.com/${cloudinit_github_user_ssh_pub}.keys >> /home/automation/.ssh/authorized_keys
  - apt-get install -y qemu-guest-agent
  - systemctl enable --now qemu-guest-agent


packages:
  - jq
  - curl
  - git
  - ansible
  - tmux

users:
- default
- name: automation
  groups: sudo
  shell: /bin/bash
  sudo: ['ALL=(ALL) NOPASSWD:ALL']
  ssh_authorized_keys:
    - "${ssh_key}"

preserve_hostname: false
manage_etc_hosts: false
fqdn: ${hostname}.${domain}


final_message: "The system is finally up, after $UPTIME seconds"
power_state:
  delay: "+1"
  mode: reboot