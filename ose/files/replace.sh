#!/bin/bash
#!/bin/bash
dst=$1
sed -i '/openshift_use_calico/a \ \ - role: contrail_master \n \ \ \ when: openshift_use_contrail | default(false) | bool' $dst/playbooks/openshift-master/private/config.yml
