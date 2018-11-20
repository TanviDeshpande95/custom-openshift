#!/bin/bash
dest=$1
cat $PWD/../files/patch_manage_node.txt >> $dest/playbooks/openshift-node/private/manage_node.yml
