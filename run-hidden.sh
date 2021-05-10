sudo docker kill ears-server_acquisition ears-server_tomcat ears-server_mysql
sudo docker system prune &&
sudo docker-compose build &&
sudo docker-compose up -d
sleep 80
echo Finished! Go to http://localhost:8181/ears
echo -ne '\007'

