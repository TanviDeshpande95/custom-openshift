#!/bin/bash

sed -i -e '/nested_mode_contrail = false/r /home/custom-openshift/ose/files/contrail_config.txt' /home/openshift-ansible/inventory
