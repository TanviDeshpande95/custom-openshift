#!/bin/bash
sed -e '/tasks/{a \ \ \- group_by:\n \ \ \ \ \ \key: oo_nodes_use_{{ (openshift_use_contrail | default(False)) | ternary('contrail','nothing') }}\n \ \ \ changed_when: False' -e ':a;n;ba}' /home/openshift-ansible/playbooks/openshift-node/private/additional_config.yml > /home/new.yml ; mv /home/new.yml /home/openshift-ansible/playbooks/openshift-node/private/additional_config.yml
