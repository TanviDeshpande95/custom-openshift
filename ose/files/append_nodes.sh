#!/bin/bash
dest=$1
echo $dest
cat $PWD/append.txt >> $dest/playbooks/openshift-node/private/additional_config.yml


