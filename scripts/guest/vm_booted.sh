#!/bin/bash

HOST="10.0.2.2"
USER=rasse
COMMAND="bash ~/vm/scripts/usb-passthrough.sh add most"
until ssh -oStrictHostKeyChecking=no $USER@$HOST $COMMAND
do
	echo "Retrying..."
	sleep 1
done
