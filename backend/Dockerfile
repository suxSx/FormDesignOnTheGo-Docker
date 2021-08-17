### Stage 3: Build Spring Boot.
# After you have created jar file with: gradle bootBuildImage
# we would like to use openjdk:8-jdk-alpine for small size. -BUt since our spring boot are new we need a newer version.
# The jar file wil be in /backend/build/libs/firstspingapp-0.0.1-SNAPSHOT.jar
FROM openjdk:11.0.4-jre-slim

#Creating tmp volum
VOLUME /tmp

#Exposing port 8080
EXPOSE 8080

#Creating app folder for backend
RUN mkdir -p /backend/

#Also log folder
RUN mkdir -p /backend/logs/

#Copyien the jar file
COPY /build/libs/firstspringapp-0.0.1-SNAPSHOT.jar /backend/app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=container", "-jar", "/backend/app.jar"]