#!/bin/bash

vagrant up
ansible-playbooks playbooks/nodemaster-conf.yml
ansible-playbooks playbooks/nodes-conf.yml