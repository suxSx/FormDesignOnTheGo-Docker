#### Stage -1: Readme Info
# To build jar file: gradle bootBuildImage
# To build run: docker build -t formdesign-spring-docker .
# To test: docker run -p 80:80 formdesign-spring-docker

#### Stage 1: Build react app
# Define a docker image to work with, using a build that have node.js
FROM tiangolo/node-frontend:10 as build-stage

# Setting Work dir inside docker image
WORKDIR /frontend

# Copy JSON packed for node module to docker image, first is local from docker file second is addr docker container
COPY /frontend/package*.json /frontend/

# Running npm install since we are in frontend folder in docker
RUN npm install

# Copy front end files to front end in docker
COPY /frontend/ /frontend/

# Building frontend application
RUN npm run build

#### Stage 2: Building install nginx image and copy build app to container
FROM nginx:1.15

# Still in the same work space so we can copy the build files
COPY --from=build-stage /frontend/build/ /usr/share/nginx/html

# Copy the default nginx.conf provided by tiangolo/node-frontend
COPY --from=build-stage /nginx.conf /etc/nginx/conf.d/default.conf

### Stage 3: Build Spring Boot.
# After you have created jar file with: gradle bootBuildImage
# we would like to use openjdk:8-jdk-alpine for small size. -BUt since our spring boot are new we need a newer version.
# The jar file wil be in /backend/build/libs/firstspingapp-0.0.1-SNAPSHOT.jar
FROM openjdk:11.0.4-jre-slim

#Creating tmp volum
VOLUME /tmp

#Creating app folder for backend
RUN mkdir -p /backend/

#Also log folder
RUN mkdir -p /backend/logs/

#Copyien the jar file
COPY /backend/build/libs/firstspringapp-0.0.1-SNAPSHOT.jar /backend/app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=container", "-jar", "/backend/app.jar"]
