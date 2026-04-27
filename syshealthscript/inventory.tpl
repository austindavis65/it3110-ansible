[servers]
remote-host ansible_host={{ANSIBLE_HOST}} ansible_become_pass={{ANSIBLE_PASS}}

[all:vars]
ansible_user={{ANSIBLE_USER}}
ansible_ssh_private_key_file=~/.ssh/id_rsa
