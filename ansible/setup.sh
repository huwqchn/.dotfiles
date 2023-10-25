#!/bin/bash

set -e

function have {
	command -v "$1" &>/dev/null
}

# install ansible
have ansible || paru ansible

# install ansible community plugins
[ -d ~/.ansible/collections/ansible_collections/community ] ||
	ansible-galaxy collection install community.general

[ -d ~/.ansible/collections/ansible_collections/kewlfft ] ||
	ansible-galaxy collection install kewlfft.aur

# Run Ansible
ansible-playbook -i ./hosts ./playbook.yaml --ask-become-pass
