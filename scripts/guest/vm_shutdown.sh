#!/bin/bash

HOST="10.0.2.2"
USER=rasse
COMMAND="bash ~/vm/scripts/host/vm_shutdown.sh"
until ssh -oStrictHostKeyChecking=no $USER@$HOST $COMMAND
do
	echo "Retrying..."
	sleep 1
done
