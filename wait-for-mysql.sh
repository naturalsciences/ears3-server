#!/bin/bash
# wait-for-mysql.sh

set -e

host="$1"
port="$2"
user="$3"
password="$4"
database="$5"
shift 5
cmd="$@"

#wait populate script
#echo "Starting Tomcat only when mysql is up"
#while ! mysql -h "$host" -P "$port" -u "$user" -p"$password" -D "$database" -s -N -e "select count(*) from casino.event;" | grep -q 0
#do
#  echo "mysql -h $host -P $port -u $user -ppassword -D $database failed. Retry in 10s." | egrep .
#  sleep 10
#done
#>&2 echo "MySQL is populated - executing command"
sleep 60
#a simplification so that mysql doesn't need to be installed
exec $cmd
