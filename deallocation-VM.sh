#!/bin/bash
nextcount=0
while [ $nextcount -ne 1 ]
do

echo "List of VM's"
az vm list -d -o table

echo "Enter VM Name:"
read vmname

echo "Enter Resource group Name:"
read vmrg

       echo "Checking VM already in running state or not"
       vm_status=$(az vm get-instance-view --name $vmname --resource-group $vmrg --query instanceView.statuses[1] --output table | grep -o "VM running")
       echo $vm_status
       vm_current_state="VM running"
        if [[ $vm_current_state == $vm_status ]]; then

          echo "-------Deallocating VM------"
           az vm deallocate --resource-group $vmrg --name $vmname

        else

          echo "------VM is not running------"

        fi
        nextcount=1
    echo "Do you want to continue for another VM then press yes or no"
    read temp
    if [ $temp = 'yes' ]; then
    nextcount=0
    fi
done