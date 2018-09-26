#!/bin/bash

sed -i '/openshift_use_calico/a \ \ - role: contrail_master \n \ \ \ when: openshift_use_contrail | default(false) | bool' /root/ose/openshift-ansible/playbooks/openshift-master/private/config.yml
