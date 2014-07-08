#!/bin/bash

HOST="10.0.2.2"
USER=rasse
COMMAND="bash ~/vm/scripts/vm_booted_host.sh"
until ssh -oStrictHostKeyChecking=no $USER@$HOST $COMMAND
do
	echo "Retrying..."
	sleep 1
done
