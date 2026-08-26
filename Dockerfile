FROM tomcat:9.0.76-jdk11

COPY ears3.war ears3.war
COPY ears3Nav.war ears3Nav.war
COPY ears3Nav.properties ears3Nav.properties
COPY ears_base_ddl.sql ears_base_ddl.sql
COPY tomcat-users.xml /usr/local/tomcat/conf/
