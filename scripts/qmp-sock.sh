until echo "
{ \"execute\": \"qmp_capabilities\" }
" | nc -U /home/rasse/vm/qmp-sock
do
	echo Waiting for qmp-sock to be available...
	sleep 1
done
chown rasse /home/rasse/vm/qmp-sock
chgrp users /home/rasse/vm/qmp-sock
