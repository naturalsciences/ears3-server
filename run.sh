sudo docker kill ears-server_acquisition ears-server_postgres ears-server_tomcat ears-server_mysql
sudo docker system prune &&
sudo docker-compose build &&
sudo docker-compose up -d
sleep 80
echo Finished! Go to http://localhost/ears3
echo -ne '\007'
