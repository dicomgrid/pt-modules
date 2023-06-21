#!/bin/bash

### graceful IntelePACS Start

#Reporting status
echo "Reporting Pre Cluster status..."
/opt/intelerad/bin/padmin manageCluster status
echo "Reporting Pre PACS status..."
/opt/intelerad/bin/padmin reportPacsStatus

# Start IntelePACS Database Services
echo "Attempting graceful start of Sybase service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/sybase -v start
echo "Attempting graceful start of Postgres service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/postgres-intelerad start

# Start IntelePACS Core Services
echo "Attempting graceful start of Apache web service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/apache2 start
echo "Attempting graceful start of Tomcat service..."
/opt/intelerad/bin/padmin controlTomcat -t start
echo "Attempting graceful start of IntelePACS services..."
/opt/intelerad/bin/padmin PACS start

# Start Cluster services
echo "Attempting graceful start of Clustering services (corosync/pacemaker)..."
sudo systemctl start corosync
sudo systemctl start pacemaker

#Reporting status
echo "Reporting Post Cluster status..."
/opt/intelerad/bin/padmin manageCluster status
echo "Reporting Post PACS status..."
/opt/intelerad/bin/padmin reportPacsStatus

echo "..."
echo "All jobs complete!"
