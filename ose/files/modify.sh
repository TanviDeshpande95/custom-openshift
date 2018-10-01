#!/bin/bash
dest=$1
sed -e '/changed_when: False/{a \ \ \- group_by:\n \ \ \ \ \ \key: oo_nodes_use_{{ (openshift_use_contrail | default(False)) | ternary("'"contrail"'","'"nothing"'") }}\n \ \ \ changed_when: False' -e ':a;n;ba}' $dest/playbooks/openshift-node/private/additional_config.yml > $dest/new.yml ; mv $dest/new.yml $dest/playbooks/openshift-node/private/additional_config.yml
