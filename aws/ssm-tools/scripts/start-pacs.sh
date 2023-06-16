
### Graceful IntelePACS Start
# Start IntelePACS Database Services
echo "Attempting gracefull start of Sybase service..." &&
/opt/intelerad/bin/padmin sudo /etc/init.d/sybase -v start > /dev/null 2>&1 &&
echo "Attempting gracefull start of Postgres service..." &&
/opt/intelerad/bin/padmin sudo /etc/init.d/postgres-intelerad start > /dev/null 2>&1 && 
# Start IntelePACS Core Services
echo "Attempting gracefull start of Apache web service..." &&
/opt/intelerad/bin/padmin sudo /etc/init.d/apache2 start > /dev/null 2>&1 && 
echo "Attempting gracefull start of Tomcat service..." &&
/opt/intelerad/bin/padmin controlTomcat -t start > /dev/null 2>&1 && 
echo "Attempting gracefull start of IntelePACS services..." &&
/opt/intelerad/bin/padmin PACS start > /dev/null 2>&1 && 
# Start Cluster services 
echo "Attempting gracefull start of Clustering services (corosync/pacemaker)..." &&
sudo systemctl start corosync > /dev/null 2>&1 &&
sudo systemctl start pacemaker > /dev/null 2>&1 &&
echo "..."
echo "All jobs complete!"