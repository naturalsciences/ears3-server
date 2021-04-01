FROM openjdk:8

# Update apt-get sources and install lsb_release for MongoDB installation
#RUN apt-get update && apt-get install -y lsb-release apt-utils

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
#RUN echo "deb http://repo.mongodb.org/apt/debian "$(lsb_release -sc)"/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Update apt-get sources AND install MongoDB
#RUN apt-get update && apt-get install -y mongodb-org

#COPY ./ /etc/nsa/

#WORKDIR /etc/nsa/

COPY . /acquisition
WORKDIR /acquisition

#RUN sed -i -e 's/\r$//' *.sh

# Start all
ENTRYPOINT ./startup.sh all
