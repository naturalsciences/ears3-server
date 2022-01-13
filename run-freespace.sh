#!/bin/bash
while true; do
    read -p "This will free container space, and will delete the database as well, losing all data. Type 'Yes' or 'Nn' for no." yn
    case $yn in
        [Yes]* ) 
			sudo docker kill ears-server_acquisition ears-server_tomcat ears-server_mysql ears-server_postgres
			sudo docker system prune
			sudo docker-compose build &&
			sudo docker-compose up -d
			sleep 60
			cd Acquisition_System/techsas-run/
			nohup java -jar acquisition-launcher-1.1.0-SNAPSHOT.jar 2>&1 &
			sleep 40
			echo Finished! Go to http://localhost/ears3
			echo -ne '\007'
			exit;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


