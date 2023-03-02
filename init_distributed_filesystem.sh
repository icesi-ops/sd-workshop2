#!/bin/bash

#vagrant up
ansible-playbook playbooks/nodemaster-conf.yml
ansible-playbook playbooks/nodes-conf.yml
