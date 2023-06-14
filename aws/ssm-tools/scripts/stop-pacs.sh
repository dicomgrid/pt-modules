### Graceful IntelePACS Stop
# Stop Cluster services (forces cluster move)
echo "Attempting gracefull stop of Clustering services (corosync/pacemaker)..." &&
sudo systemctl stop corosync > /dev/null 2>&1 &&
sudo systemctl stop pacemaker > /dev/null 2>&1 &&
# Stop IntelePACS Core Services
echo "Attempting gracefull stop of IntelePACS services..." &&
/opt/intelerad/bin/padmin PACS stop > /dev/null 2>&1 && 
echo "Attempting gracefull stop of Tomcat service..." &&
/opt/intelerad/bin/padmin controlTomcat -t stop > /dev/null 2>&1 && 
echo "Attempting gracefull stop of Apache web service..." &&
/opt/intelerad/bin/padmin sudo /etc/init.d/apache2 stop > /dev/null 2>&1 && 
# Stop IntelePACS Database Services
echo "Attempting gracefull stop of Postgres service..." &&
/opt/intelerad/bin/padmin sudo /etc/init.d/postgres-intelerad stop > /dev/null 2>&1 && 
echo "Attempting gracefull stop of Sybase service..." &&
/opt/intelerad/bin/padmin sudo /etc/init.d/sybase -v stop > /dev/null 2>&1 &&
echo "..."
echo "All jobs complete!"