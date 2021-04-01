#!/bin/sh
LIB_PATH=lib
LIBSIMU_PATH=libsimu
COMMON_JARS=$LIB_PATH/acquisition-db-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-eurofleets-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-authentication-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-domain-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-messaging-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-launcher-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-frontend-0.0.3-SNAPSHOT.jar
ACQUISITION_JARS=$LIB_PATH/acquisition-archiving-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-authentication-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-client-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-configuration-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-description-0.0.3-SNAPSHOT.jar:$LIB_PATH/acquisition-driver-0.0.3-SNAPSHOT.jar
VISUALIZATION_JARS=$LIB_PATH/acquisition-visualization-0.0.3-SNAPSHOT.jar

# determine classpath
CONTAINER_CLASSPATH=conf
# .. add deps
for JAR_FILE in $( find $LIB_PATH/deps -name "*.jar" ) ; do
  CONTAINER_CLASSPATH=$CONTAINER_CLASSPATH:$JAR_FILE
done
# .. add common JARs
CONTAINER_CLASSPATH=$CONTAINER_CLASSPATH:$COMMON_JARS

# simulation jar
for JAR_FILE in $( find $LIBSIMU_PATH -name "*.jar" ) ; do
  SIMULATION_JARS=$SIMULATION_JARS:$JAR_FILE
done


# .. acquisition/visualization-specific settings
MODE=$1
case "$MODE" in
	acquisition)
		CONTAINER_CLASSPATH=$CONTAINER_CLASSPATH:$ACQUISITION_JARS
		LAUNCHER=fr.ifremer.acquisition.AcquisitionLauncher
		;;
	visualization)
		CONTAINER_CLASSPATH=$CONTAINER_CLASSPATH:$VISUALIZATION_JARS
		LAUNCHER=fr.ifremer.acquisition.VisualizationLauncher
		;;
	simulation)
		CONTAINER_CLASSPATH=$CONTAINER_CLASSPATH:$SIMULATION_JARS
		LAUNCHER=fr.ifremer.simu.Launcher
		;;
	all)
		CONTAINER_CLASSPATH=$CONTAINER_CLASSPATH:$ACQUISITION_JARS:$VISUALIZATION_JARS
		LAUNCHER=fr.ifremer.acquisition.AcquisitionLauncher
		;;
	*)
		echo "usage: $0 {all|acquisition|visualization}"
		echo "  acquisition:   runs acquisition services only (no visualization)"
		echo "  visualization: runs archive visualization REST services (no acquisition)"
		echo "  simulation: runs simulation (no acquisition)"
		echo "  all:           runs all services (acquisition & visualization)"
		exit 1
		;;
esac

while true
do
	echo "[launcher] starting"
	
	java -cp "$CONTAINER_CLASSPATH" -Dlauncher=true -Dconfig.dir=conf $LAUNCHER
	if [ "$?" -ne "2" ]
	then
		echo "[launcher] exiting"
		exit 0
	fi

	echo "[launcher] stopped, restarting"
done

