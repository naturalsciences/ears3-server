FROM tomcat:9.0.22-jdk8-openjdk

COPY wait.sh wait.sh
COPY ears_base_ddl.sql ears_base_ddl.sql
COPY tomcat-users.xml /usr/local/tomcat/conf/

#RUN mkdir /etc/.java
#EXPOSE 808

#RUN echo 'Acquire::http::Pipeline-Depth 0;Acquire::http::No-Cache true;Acquire::BrokenProxy    true;' > /etc/apt/apt.conf.d/99fixbadproxy
#RUN rm -rf /var/lib/apt && apt-get clean && apt-get update
#RUN apt-get install -y mysql-client
