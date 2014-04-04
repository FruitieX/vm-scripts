#!/bin/bash

HOST=$(route print -4 | egrep "^ +0.0.0.0 +0.0.0.0 +" | awk -F' ' '{print $3}')
USER=rasse
COMMAND="bash ~/vm/scripts/vm_booted_host.sh"
until ssh $USER@$HOST $COMMAND
do
	HOST=$(route print -4 | egrep "^ +0.0.0.0 +0.0.0.0 +" | awk -F' ' '{print $3}')
	echo "Retrying..."
	sleep 1
done
