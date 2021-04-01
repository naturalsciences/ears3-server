@echo off

setlocal enabledelayedexpansion
SET current=%__CD__%
SET "CONTAINER_CLASSPATH=conf"

REM Get all file frome current position and list all .jar files
FOR /R . %%F IN (*.jar) DO (
	SET fullFilePath=%%F
	REM Remove the full file path to have only the relative path
	set str=!fullFilePath:%current%=!
	
	SET "CONTAINER_CLASSPATH=!CONTAINER_CLASSPATH!;!str!"
)
rem echo CLASSPATH = [!CONTAINER_CLASSPATH!]

java -cp "!CONTAINER_CLASSPATH!" fr.ifremer.acquisition.BrokerDump %1 %2

