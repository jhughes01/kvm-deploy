#!/usr/bin/env bash

# Author: Jackson
# Function: Deploy KVM node from template

HOSTNAME=$1
FIRSTBOOTSCRIPT=/vault/kvm-vm-templates/script.sh

# Create new node from template
virt-clone \
--original-xml /vault/kvm-vm-templates/ubuntu16.04-template.xml \
--name $HOSTNAME \
--file /vault/kvm-vm-storage/$HOSTNAME.qcow2

# Sysprep newly created node - including update and firstboot script.
virt-sysprep --domain $HOSTNAME \
--update \
--hostname $HOSTNAME \
--operations defaults \
--operations -cron-spool,-package-manager-cache \
--firstboot /vault/kvm-vm-templates/script.sh

# Start node
virsh start $HOSTNAME
