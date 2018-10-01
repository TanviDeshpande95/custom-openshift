# Integrating Contrail with existing openshift-ansible

This is a simple playbook to append Contrail SDN roles to an existing openshift-ansible deplopyer

**For the current iteration, Please use the /home mount space to download the openshift-ansible code.** 


### Steps to execute 

**On the Openshift-ansible node**

**Step 1: Change directory to /home**
```
cd /home
```

**Step2: Download Openshift-ansible from Openshift Repo**

```git clone https://github.com/openshift/openshift-ansible.git -b release-3.9```

**Step3: Download the Contrail-Openshift-ansible from Juniper Repo**
```
mkdir contrail && cd contrail &&  git clone https://github.com/Juniper/openshift-ansible.git -b release-3.9-contrail
```
**Step4: Clone the custom-openshift repo** 
```
cd /home

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
```

**Step7 : Please append the contrail inventory variables to your openshift-asible inventory**
```
openshift_use_contrail=true
contrail_version=5.0
contrail_container_tag=5.0.1-0.214
contrail_registry_insecure=true
contrail_registry=hub.juniper.net/contrail
# Username /Password for private Docker registry
#contrail_registry_username=test
#contrail_registry_password=test
vrouter_gateway=10.10.10.1

```
