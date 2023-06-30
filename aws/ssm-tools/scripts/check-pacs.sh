#! /bin/bash
service corosync status
service pacemaker status
service sybase status
service postgres-intelerad status
service apache2 status
/opt/intelerad/bin/padmin controlTomcat -t list
/opt/intelerad/bin/padmin PACS status