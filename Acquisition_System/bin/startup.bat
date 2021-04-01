@echo off

setlocal enabledelayedexpansion

SET LIB_PATH=lib
SET LIBSIMU_PATH=libsimu
SET COMMON_JARS=!LIB_PATH!/acquisition-db-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-eurofleets-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-authentication-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-domain-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-messaging-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-launcher-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-frontend-0.0.3-SNAPSHOT.jar
SET ACQUISITION_JARS=!LIB_PATH!/acquisition-archiving-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-authentication-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-client-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-configuration-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-description-0.0.3-SNAPSHOT.jar;!LIB_PATH!/acquisition-driver-0.0.3-SNAPSHOT.jar
SET VISUALIZATION_JARS=!LIB_PATH!/acquisition-visualization-0.0.3-SNAPSHOT.jar

REM determine classpath
SET "CONTAINER_CLASSPATH=conf"

REM add common JARs
SET CONTAINER_CLASSPATH=!CONTAINER_CLASSPATH!;!COMMON_JARS!

REM Get all file from current position and list all .jar files
SET current=%__CD__%
FOR /R %LIB_PATH%\deps %%F IN (*.jar) DO (
	SET fullFilePath=%%F
	rem Remove the full file path to have only the relative path
	SET str=!fullFilePath:%current%=!
	
	SET "CONTAINER_CLASSPATH=!CONTAINER_CLASSPATH!;!str!"
)

REM Get all file from current position and list all .jar files
SET current=%__CD__%
FOR /R %LIBSIMU_PATH% %%F IN (*.jar) DO (
	SET fullFilePath=%%F
	rem Remove the full file path to have only the relative path
	SET str=!fullFilePath:%current%=!
	
	SET "SIMULATION_JARS=!SIMULATION_JARS!;!str!"
)

REM Set acquisition/visualization-specific settings
IF "%1%" == "acquisition" (
	SET LAUNCHER=fr.ifremer.acquisition.AcquisitionLauncher
	SET CONTAINER_CLASSPATH=!CONTAINER_CLASSPATH!;!ACQUISITION_JARS!
) ELSE IF "%1%" == "visualization" (
	SET LAUNCHER=fr.ifremer.acquisition.VisualizationLauncher
	SET CONTAINER_CLASSPATH=!CONTAINER_CLASSPATH!;!VISUALIZATION_JARS!
) ELSE IF "%1%" == "simulation" (
	SET LAUNCHER=fr.ifremer.simu.Launcher
	SET CONTAINER_CLASSPATH=!CONTAINER_CLASSPATH!;!SIMULATION_JARS!
) ELSE IF "%1%" == "all" (
	SET LAUNCHER=fr.ifremer.acquisition.AcquisitionLauncher
	SET CONTAINER_CLASSPATH=!CONTAINER_CLASSPATH!;!ACQUISITION_JARS!;!VISUALIZATION_JARS!
) ELSE (
	echo usage: %0% {all^|acquisition^|simulation^|visualization}
	echo   acquisition:   runs acquisition services only ^(no visualization^)
	echo   visualization: runs archive visualization REST services ^(no acquisition^)
	echo   simulation: runs simulation ^(no acquisition^)
	echo   all:           runs all services ^(acquisition ^& visualization^)

	GOTO end
)

REM echo CLASSPATH = [!CONTAINER_CLASSPATH!]

:start
	echo [launcher] startup

	java -cp "!CONTAINER_CLASSPATH!" -Dlauncher=true -Dconfig.dir=conf !LAUNCHER!
	IF ERRORLEVEL 2 GOTO restart

	GOTO end

:restart
	echo [launcher] stopped, restarting
	GOTO start

:end
	echo [launcher] exiting
	EXIT /B 0

