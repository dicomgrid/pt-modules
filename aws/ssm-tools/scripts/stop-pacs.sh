#!/bin/bash

### graceful IntelePACS Stop

#Reporting status
echo "Reporting Pre Cluster status..."
/opt/intelerad/bin/padmin manageCluster status
echo "Reporting Pre PACS status..."
/opt/intelerad/bin/padmin reportPacsStatus

# Stop Cluster services (forces cluster move)
echo "Attempting graceful stop of Clustering services (corosync/pacemaker)..."
sudo systemctl stop corosync
sudo systemctl stop pacemaker

# Stop IntelePACS Core Services
echo "Attempting graceful stop of IntelePACS services..."
/opt/intelerad/bin/padmin PACS stop
echo "Attempting graceful stop of Tomcat service..."
/opt/intelerad/bin/padmin controlTomcat -t stop
echo "Attempting graceful stop of Apache web service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/apache2 stop

# Stop IntelePACS Database Services
echo "Attempting graceful stop of Postgres service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/postgres-intelerad stop
echo "Attempting graceful stop of Sybase service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/sybase -v stop

#Reporting status
echo "Reporting Pre Cluster status..."
/opt/intelerad/bin/padmin manageCluster status
echo "Reporting Pre PACS status..."
/opt/intelerad/bin/padmin reportPacsStatus

echo "..."
echo "All jobs complete!"
