#!/bin/bash

HOST_MAC_ADDR="bc-5f-f4-f7-c9-30"
HOST=$(arp -a | grep $HOST_MAC_ADDR | awk '{ print $1; }')
USER=rasse
COMMAND="bash ~/vm/scripts/vm_shutdown_host.sh"
until ssh $USER@$HOST $COMMAND
do
	HOST=$(arp -a | grep $HOST_MAC_ADDR | awk '{ print $1; }')
	echo "Retrying..."
	sleep 1
done
