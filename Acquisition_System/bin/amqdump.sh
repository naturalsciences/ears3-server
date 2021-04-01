#!/bin/sh
CONTAINER_CLASSPATH=conf

for JAR_FILE in $( find lib -name "*.jar" ) ; do
  CONTAINER_CLASSPATH=$CONTAINER_CLASSPATH:$JAR_FILE
done

java -cp "$CONTAINER_CLASSPATH" fr.ifremer.acquisition.BrokerDump $1 $2

