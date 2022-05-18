#!/bin/bash
sudo docker kill ears-server_acquisition ears-server_tomcat ears-server_mysql ears-server_postgres
sudo docker-compose build &&
sudo docker-compose up -d
sleep 60
cd Acquisition_System/techsas-run/
nohup java -Xms512m -Xmx2g -jar acquisition-launcher-1.1.0-SNAPSHOT.jar 2>&1 &
#sleep 40
echo Finished! Go to http://localhost/ears3
echo -ne '\007'
