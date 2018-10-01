# Integrating Contrail with existing openshift-ansible

This is a simple playbook to append Contrail SDN roles to an existing openshift-ansible deplopyer

**For the current iteration, Please use the /home mount space to download the openshift-ansible code.** 


### Steps to execute 

**On the Openshift-ansible node**

**Step 1: Change directory to /home**
```cd /home```

**Step2: Download Openshift-ansible from Openshift Repo**

```git clone https://github.com/openshift/openshift-ansible.git -b release-3.9```

**Step3: Download the Contrail-Openshift-ansible from Juniper Repo**
```
mkdir contrail && cd contrail &&  git clone https://github.com/Juniper/openshift-ansible.git -b release-3.9-contrail
```
**Step4: Clone the custom-openshift repo** 
```
git clone https://github.com/Juniper/custom-openshift.git
```
**Step5: Go to the playbook Directory and execute the playbook** 


```
cd /home/custom-openshift/ose/playbooks/

[root@ip-10-10-10-10 playbooks]# ansible-playbook integrate.yaml 
 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not
match 'all'

Enter path to your openshift-ansible: /home/openshift-ansible
Enter path to place openshift-ansible-contrail: /home/contrail/openshift-ansible

PLAY [127.0.0.1] ************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************
ok: [127.0.0.1]

TASK [pull the latest openshift-contrail-code from git] *********************************************************
ok: [127.0.0.1]

TASK [copy contrail_master into your openshift-ansible-deployer] ************************************************
changed: [127.0.0.1]

TASK [copy contrail_nodes folder into your openshift-ansible-deployer] ******************************************
changed: [127.0.0.1]

TASK [Set permissions for replacement master config files] ******************************************************
changed: [127.0.0.1]

TASK [Execute the script] ***************************************************************************************
changed: [127.0.0.1]

TASK [Set permissions for replacement node config files] ********************************************************
changed: [127.0.0.1]

TASK [Execute the script] ***************************************************************************************
changed: [127.0.0.1]

TASK [Set permissions for replacement node config files] ********************************************************
changed: [127.0.0.1]

TASK [Execute the script] ***************************************************************************************
changed: [127.0.0.1]

TASK [Set permissions for replacement contrail config files] ****************************************************
changed: [127.0.0.1]

PLAY RECAP ******************************************************************************************************
127.0.0.1                  : ok=11   changed=9    unreachable=0    failed=0   

[root@ip-10-10-10-10 playbooks]#
```

**Step6 : Verify if contrail code has been appended to the Openshift-playbooks**

```
[root@ip-10-10-10-10 playbooks]# cd /home/openshift-ansible/
[root@ip-10-10-10-10 openshift-ansible]# 
[root@ip-10-10-10-10 openshift-ansible]# git status
# On branch release-3.9
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   playbooks/openshift-master/private/config.yml
#	modified:   playbooks/openshift-node/private/additional_config.yml
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	roles/contrail_master/
#	roles/contrail_node/
no changes added to commit (use "git add" and/or "git commit -a")
[root@ip-10-10-10-10 openshift-ansible]# git diff
diff --git a/playbooks/openshift-master/private/config.yml b/playbooks/openshift-master/private/config.yml
index bdbc206..26d45db 100644
--- a/playbooks/openshift-master/private/config.yml
+++ b/playbooks/openshift-master/private/config.yml
@@ -184,6 +184,8 @@
     when: openshift_use_nuage | default(false) | bool
   - role: calico_master
     when: openshift_use_calico | default(false) | bool
+  - role: contrail_master 
+    when: openshift_use_contrail | default(false) | bool
   tasks:
   - import_role:
       name: kuryr
diff --git a/playbooks/openshift-node/private/additional_config.yml b/playbooks/openshift-node/private/additional
index b054859..cc9a29a 100644
--- a/playbooks/openshift-node/private/additional_config.yml
+++ b/playbooks/openshift-node/private/additional_config.yml
@@ -7,6 +7,9 @@
   - group_by:
       key: oo_nodes_use_{{ (openshift_use_flannel | default(False)) | ternary('flannel','nothing') }}
     changed_when: False
+  - group_by:
+      key: oo_nodes_use_{{ (openshift_use_contrail | default(False)) | ternary("contrail","nothing") }}
+    changed_when: False
   # Create group for calico nodes
   - group_by:
       key: oo_nodes_use_{{ (openshift_use_calico | default(False)) | ternary('calico','nothing') }}
@@ -67,3 +70,9 @@
       name: kuryr
       tasks_from: node
     when: openshift_use_kuryr | default(false) | bool
+- name: Additional node config
+  hosts: oo_nodes_use_contrail
+  roles:
+  - role: contrail_node
+    contrail_master: "{{ groups.masters.0 }}"
+    when: openshift_use_contrail | default(false) | bool
[root@ip-10-10-10-10 openshift-ansible]#
```

