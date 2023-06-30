#! /bin/bash
sudo su - admin
# Start IntelePACS Database Services
echo "Attempting graceful start of Sybase service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/sybase -v start > /dev/null 2>&1
echo "Attempting graceful start of Postgres service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/postgres-intelerad start > /dev/null 2>&1

# Start IntelePACS Core Services
echo "Attempting graceful start of Apache web service..."
/opt/intelerad/bin/padmin sudo /etc/init.d/apache2 start > /dev/null 2>&1
echo "Attempting graceful start of Tomcat service..."
/opt/intelerad/bin/padmin controlTomcat -t start > /dev/null 2>&1
echo "Attempting graceful start of IntelePACS services..."
/opt/intelerad/bin/padmin PACS start

# Start Cluster services
echo "Attempting graceful start of Clustering services (corosync/pacemaker)..."
sudo systemctl start corosync > /dev/null 2>&1
sudo systemctl start pacemaker > /dev/null 2>&1

sudo service corosync status
sudo service pacemaker status
sudo service sybase status
sudo service postgres-intelerad status
sudo service apache2 status
/opt/intelerad/bin/padmin controlTomcat -t list
/opt/intelerad/bin/padmin PACS status
