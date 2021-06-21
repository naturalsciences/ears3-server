
# **Installation of the EARS server**

## Prerequisites

The main prerequisite is linux with the docker daemon installed. Installing docker,docker-compose, installing git, get the EARS server files and building an image from the Dockerfile all require a fast and stable internet connection (on-shore cable or 4G preferred over satellite). This is not always possible on board, so plan the installation ahead. The EARS web applications can be installed on an already present physical or virtual server, or can be installed on-shore inside a virtual machine, taken on-board and deployed there. The server must be accessible from the ship&#39;s LAN.

To create a linux virtual machine, we refer to the many resources available on this topic, for instance [here](https://linuxconfig.org/install-and-set-up-kvm-on-ubuntu-18-04-bionic-beaver-linux). The rest of these guidelines is written with Ubuntu in mind. If only windows servers are available on board, virtualisation is a must.

## Physical requirements

All data is stored inside a docker container (see below). This will increase in size as the campaigns are going on. The data is available as a database as well as NetCDF files.

## Create EARS datagrams

EARS needs three datagrams put on the network in a very specific format, each for navigation, thermosalinometry and meteorology (weather).

If the data is sent out via a serial port, it needs to be put on Ethernet. This can be done by using a MOXA Nport 5410 Serial Device Server.

The techniques needed to combine data into the datagrams are not part of these guidelines and are understood to be programmable by sysadmins.

**Datagram description navigation data (POS:3101):**

Start identifier: always $EFPOS

Date of position: ddmmyy

UTC time of position: hh24mmss

Longitude in decimal degrees

Latitude in decimal degrees

Ship heading in °

FO/AF speed in kn

Water depth in m

Course over ground in °

Speed over ground in kn

_ **Example:** _

$EFPOS,131017,132035,3.01803,51.44738,216.2,8.9,-27.7,215.4,8.7

**Datagram description meteo data (MET:3102):**

Start identifier: always $EFMET

Date of position: ddmmyy

UTC time of position: hh24mmss

Mean wind speed in m/s

Wind gust speed in m/s

Wind direction in °

Atmospheric temperature in °C

Humidity in %

Solar radiation in W/m²

Atmospheric pressure in hPa

Sea water temperature in °C

_ **Example:** _

$EFMET,131017,132035,2.81,2.81,150.4,11.05,,189.07,1018.12

**Datagram description thermosalinograph data (TSS:3103):**

Start identifier: always $EFTSS

Date of position: ddmmyy

UTC time of position: hh24mmss

Salinity in PSU

Sea water temperature in °C

Raw fluorometry in V

Conductivity in S/m

Sigma theta in kg/m³

_ **Example:** _

$EFTSS,131017,132035,33.5449,14.7808,0.6275,41.1335,24.8983

## Install docker (on physical or virtual machine)

Ubuntu: Follow the guidelines on [https://docs.docker.com/install/linux/docker-ce/ubuntu/](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

Debian, CentOS, Fedora also available.

After installation, ensure that the docker daemon will be started when the server or virtual machine reboots, and start it right now:

```
sudo systemctl enable docker && sudo systemctl start docker
```

## Install docker-compose

Ubuntu: follow the guidelines on https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04:

- Verify the current release of docker-compose on `https://github.com/docker/compose/releases`
- Install it: ```sudo curl -L https://github.com/docker/compose/releases/download/<version>/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose```
- And set the permissions: `sudo chmod +x /usr/local/bin/docker-compose`

## Install git or download as zip from github

Ubuntu:

```
sudo apt-get update
sudo apt-get install git
```

Or download the zip from https://github.com/naturalsciences/ears3-server/archive/refs/heads/master.zip, and unzip.

## Get the required files for the EARS server, including the Dockerfile

Go to where you want to install the docker container. The location has no special need for permissions, as all docker operations require root rights anyway. `/home/general-user/` is a fine location.

```
cd <installation directory>
git clone https://github.com/naturalsciences/ears3-server.git
cd ears3-server
```

Or unzip the zip into <installation directory>/ears3-server.

You also need to download the acquisition launcher from https://share.naturalsciences.be/f/18ddde1d5eb14981b8ee/?dl=1 and put it in ears3-server/Acquisition_System/techsas-run. Recent builds became too large for github (100MB).

## Create the docker container and run the image

```
sudo docker-compose build
sudo docker-compose up -d
```

For your convenience you can also just run `./run.sh`.
 
The -d flag starts the container based on the image in a detached mode, meaning that you can continue the terminal session. If you shutdown and reboot the server that hosts the EARS server container, the container will always restart along with the whole server.

When you run the image, the different components are started in certain order. The web server (tomcat) is the latest as it has to wait for the database to be completed. Wait at least a minute, then visit the following addresses in your web browser (the date ranges are just examples and no data can be returned if the acquisition did not yet run):
```
http://localhost/ears3/html/event
http://localhost/ears3/events
http://localhost/ears3Nav/tss/getLast/xml
http://localhost/ears3Nav/tss/getLast/datagram
http://localhost/ears3Nav/tss/getLast/json
http://localhost/ears3Nav/met/getLast/xml
http://localhost/ears3Nav/met/getLast/json
http://localhost/ears3Nav/met/getLast/datagram
http://localhost/ears3Nav/nav/getLast/xml
http://localhost/ears3Nav/nav/getLast/json
http://localhost/ears3Nav/nav/getLast/datagram

http://localhost/ears3Nav/tss/getNearest/xml?date=2021-06-25T08:39:00
http://localhost/ears3Nav/tss/getNearest/json?date=2021-06-25T08:39:00
http://localhost/ears3Nav/tss/getNearest/datagram?date=2021-06-25T08:39:00
http://localhost/ears3Nav/met/getNearest/xml?date=2021-06-25T08:39:00
http://localhost/ears3Nav/met/getNearest/json?date=2021-06-25T08:39:00
http://localhost/ears3Nav/met/getNearest/datagram?date=2021-06-25T08:39:00
http://localhost/ears3Nav/nav/getNearest/xml?date=2021-06-25T08:39:00
http://localhost/ears3Nav/nav/getNearest/json?date=2021-06-25T08:39:00
http://localhost/ears3Nav/nav/getNearest/datagram?date=2021-06-25T08:39:00

http://localhost/ears3Nav/tss/getBetween/xml?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z
http://localhost/ears3Nav/tss/getBetween/json?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z
http://localhost/ears3Nav/tss/getBetween/datagram?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z
http://localhost/ears3Nav/met/getBetween/xml?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z
http://localhost/ears3Nav/met/getBetween/json?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z
http://localhost/ears3Nav/met/getBetween/datagram?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z
http://localhost/ears3Nav/nav/getBetween/xml?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z
http://localhost/ears3Nav/nav/getBetween/json?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z
http://localhost/ears3Nav/nav/getBetween/datagram?startDate=2020-08-18T00:00:00Z&endDate=2021-06-25T08:39:00Z

http://localhost:8080
```
Replace localhost with the server&#39;s IP adress and the actual port you have configured (see lower).

Make sure that the server is accessible from the network.

## Adresses, ports and environment variables

The EARS webservices are reachable on [http://localhost](http://localhost) and the acquisition server on [http://localhost:8080](http://localhost:8080), by default. You can modify these ports in the .env file but this is not recommended. If a port is already taken, you either change the port in the .env file, or preferrably kill the application that takes the port. In order to find applications using a port, use eg. `sudo netstat -tulpn | grep 8080`, note the pid in the last column and then `sudo kill <pid>`

You have to change the RV identifier in the .env file. Please change EARS_PLATFORM=SDN:C17::11BE to the C17 (ICES) code of the RV this software will be run on. The C17 codes are here: http://vocab.nerc.ac.uk/collection/C17/current/

## Usage

Go to `http://localhost/ears3/html/event` or simply `http://localhost/ears3` to create new events. New programs and cruises are to be created with the desktop client application. In the web application you are first prompted to provide your name and email address. The manual for this web page can be found at the end of the client manual, [here](https://github.com/naturalsciences/ears/releases/download/3.0.1beta/Eurofleets+_D3.9_manual_ears3_client_webapp.pdf).

Go to `http://localhost/ears3/sml?platformUrn=SDN:C17::XYZA` to see the Sensor ML description for the whole ship. Follow the links for the events of specific devices.

Go to `http://localhost/ears3/cruise/csr?identifier=cruise_identifier` to see the a full SDN Cruise Summary Report. Cruises are created with the java client desktop application. 

Go to `http://localhost:8080` for the acquisition.

## View the database, e.g. with psql or DBeaver

Install psql or DBeaver.

```
sudo apt-get update
sudo apt-get install postgresql-client
sudo apt-get install dbeaver-ce
```

First retrieve the ip address of the PostgreSQL container:

```
sudo docker inspect ears-server_postgres
```
and note the value for the key &quot;IPAddress&quot;.

Shorthand:
```
sudo docker inspect ears-server_postgres | pcregrep -o1 '"IPAddress": "([0-9\.]+)"'
```

Create a new connection in DBeaver towards this IP address, using as database name &#39;ears3&#39;, user &#39;ears&#39; and password &#39;ears&#39;, and using the default port 5432. The database is also reachable via localhost:6543.

## Or by command line

With command line postgres, you can use:

```
psql -h localhost -p 6543 -U ears -d ears3 -c "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE';"
```

Type the password (ears) and verify the tables have been created correctly (27 tables). Later you can use this to verify data insertion, eg. by:

```
psql -h localhost -p 6543 -U ears -d ears3 -c "select * from Navigation limit 10;"
```

## Verify the acquisition works

The acquisition module stores the datagrams created above as NetCDF files and in the EARS database as above. For EARS to work, at least the navigation datagram must be sent to UDP port 3101 of the server EARS is running on, the meteorology datagram to UDP port 3102 and the Thermosalinometry datagram to UDP port 3103.

This ideally only works on a research vessel. To test if the acquisition server has correctly run, we provide a small test program that can send fake information to these ports. This can be found in the FileToUDP/ directory.

For this you need to install Java JDK 8 or higher on the host running the docker. On Ubuntu:

```
sudo apt install openjdk-8-jdk openjdk-8-jre
```

Then, to run the program, type:

```
java -jar FileToUDP/FileToUDP.jar FileToUDP/09022016.posicion.raw 3101 1
```

You immediately see the output being sent. In order to run this process in the background and log what it wrote to a log file, use the following three commands for resp. position, meteorology and thermosalinometry.

```
nohup java -jar FileToUDP/FileToUDP.jar FileToUDP/09022016.posicion.raw  3101 1 > ~/filetoudp.log 2>&1 &
nohup java -jar FileToUDP/FileToUDP.jar FileToUDP/08052016.meteo.raw  3102 1 > ~/filetoudp.log 2>&1 &
nohup java -jar FileToUDP/FileToUDP.jar FileToUDP/09052016.termosal.raw 3103 1 > ~/filetoudp.log 2>&1 &
```
Inspect this actually is received by the acquisition module by visiting http://localhost:8080/#/dashboard. you can also check the log output of docker for acquisition:

```
sudo docker logs ears-server_acquisition
```

Also verify the urls from above: 
```http://localhost/ears3Nav/nav/getLast/xml```
```http://localhost/ears3Nav/met/getLast/xml```
```http://localhost/ears3Nav/tss/getLast/xml```

To see if the data is sent to EARS. The data should continously update upon refresh.

The data is also saved as NetCDF files. These can be found in the netcdf/ directory for nav, met and tss. Please note that a full day of navigation from the above fake datagram would take about 2 GB of data. So in some scenarios you might want to disable the creation of these files. However, for the 2020 Eurofleets+ campaigns, the Principal Investigator must report these NetCDF files in the EMODnet Ingestion Portal together with his other campaign data. So please keep this enabled and send him these files, as he will need them for his data submission!

To disable EARS from creating these NetCDF files, comment out the following lines in the file Acquisition\_System/bin/conf/application.properties:

```
acquisition.archiving.netcdf.file=./log/netcdf/{sensor}/{sensor}-{frame}-{date,yyyy-Mmdd-HH}.nc
```

After this, run `./run.sh`

## Data volumes

In order to persist the information in the database and the ontology and to safeguard it for when the docker container would be restarted or even deleted, the data is persisted in a directory outside of the docker container. These are &#39;ears\_postgres\_data&#39; and &#39;ontologies&#39;. Do not delete these directories. The fastest way to save the vessel ontology is to put in in the 'ontologies' directory.

## Troubleshooting

If the application doesn't work, and the tomcat logs show `org.postgresql.util.PSQLException: The connection attempt failed.`, this most likely is a firewall issue. Read [this page](https://forums.docker.com/t/no-route-to-host-network-request-from-container-to-host-ip-port-published-from-other-container/39063/11). 

Get the IP addresses of the docker containers: 

```
sudo docker inspect ears-server_postgres | pcregrep -o1 '"IPAddress": "([0-9\.]+)"' and
sudo docker inspect ears-server_tomcat | pcregrep -o1 '"IPAddress": "([0-9\.]+)"'
```

Note the ip addresses, and replace the last digits with 0/16. Run

```firewall-cmd --permanent --zone=public --add-rich-rule='rule family=ipv4 source address=x.y.z.0/16 accept' && firewall-cmd --reload```

for both IP addresses, or (unsecure):

```Systemctl stop firewalld.service```

Do not modify the Dockerfile or the docker-compose.yml files. If any other file (the wars or the .env file) is changed you will need to rebuild the image(`sudo docker-compose build`). The easiest is to run ``./run.sh``.

You can read the logs of the individual modules like so:

The database: `sudo docker logs ears-server_postgres`

The web applications: `sudo docker logs ears-server_tomcat`

The acquisition module: `sudo docker logs ears-server_acquisition`

If you need to kill the docker images, for instance if you make a change in the Dockerfile, enter `sudo docker kill ears-server_acquisition ears-server_postgres`

The Dockerfile should not be changed, only to change the access password for the vessel ontology, see higher.

## Coping with updates

If a new version of any web application (ears3.war, ears3Nav.war) would need a replacement (of which you will be informed by email) please follow this procedure:

- Ensure you have a stable and fast internet connection
- ssh to the server
- cd to the ears3-server directory, replace the files and
```
./run.sh
```

The build command is smart enough to start rebuilding only the steps that are not affected by the file change (so this is faster than the original build).

## Installing the client

The EARS client is a desktop application that interacts with this server. Cruises and programs should be created with the client, events can be created with both the web application on this server or the desktop client. This is a java desktop installation, to be installed from [here](https://github.com/naturalsciences/ears/releases). The manual is [here](https://github.com/naturalsciences/ears/releases/download/3.0.1beta/Eurofleets+_D3.9_manual_ears3_client_webapp.pdf).
