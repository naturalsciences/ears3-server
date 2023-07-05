#!/bin/bash

read -r pPID pNAME <<< $(sudo netstat -tulpn | grep -w ':80' | awk '{print $7;}' | cut -f1,2 -d/ --output-delimiter=" ")
if [[ $pNAME != "" ]] && [[ $pPID != "" ]] && [[ $pNAME != "docker-proxy" ]]; then
    echo "Killing $pPID: $pNAME"
    sudo kill $pPID;
fi;

sudo docker kill ears-server_acquisition ears-server_tomcat ears-server_mysql ears-server_postgres
sudo docker-compose build &&
sudo docker-compose up -d
sleep 60
cd Acquisition_System/techsas-run/
nohup java -Xms512m -Xmx2g -jar acquisition-launcher-1.1.0-SNAPSHOT.jar 2>&1 &
sleep 40

cd -
./eurofleets.sh
echo Finished! Go to http://localhost/ears3
echo -ne '\007'
