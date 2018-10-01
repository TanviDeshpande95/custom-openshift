#!/bin/bash

sed -i -e '/nested_mode_contrail = false/r /usr/share/ansible/custom-openshift/ose/files/contrail_config.txt' /usr/share/ansible/openshift-ansible/inventory/ose-install
