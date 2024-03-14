#!/bin/bash

selected_profile=$1

if [ -z "$selected_profile" ]
then
	echo "You didn't provide a profile (remote_db/embedded_db, embedded_acquisition)"
	exit 1
else
	profiles=(remote_db embedded_db embedded_acquisition)
	match=0
	for profile in "${profiles[@]}"; do
    		if [[ $selected_profile = "$profile" ]]; then
        		match=1
        		break
    		fi
	done
	if [[ $match = 0 ]]; then
    		echo "$selected_profile is not allowed as a profile (only remote_db/embedded_db, embedded_acquisition)"
		exit 1
	fi
fi

read -r pPID pNAME <<< $(sudo netstat -tulpn | grep -w ':80' | awk '{print $7;}' | cut -f1,2 -d/ --output-delimiter=" ")
if [[ $pNAME != "" ]] && [[ $pPID != "" ]] && [[ $pNAME != "docker-proxy" ]]; then
	echo "Killing $pPID: $pNAME"
	sudo kill $pPID;
fi;

sudo docker kill ears3-server-tomcat ears3-server-tomcat-remote ears3-server-postgres
sudo docker compose --profile $selected_profile build &&
sudo docker compose --profile $selected_profile  up -d

if [[ $selected_profile = "embedded_acquisition" ]]; then
	echo "starting TechSAS in 60 seconds..."
	sleep 60
	cd Acquisition_System/techsas-run/
	nohup java -Xms512m -Xmx2g -jar acquisition-launcher-1.1.0-SNAPSHOT.jar 2>&1 &
	sleep 40
fi
cd -
echo -ne '\007'
