# Create Backend Docker file
This project uses React as a Frontend and Springboot as a backend, with the help of postgresql. In order to create a docker file, we need to first setup the images needed. For then to create a docker file.

## Two ways to go
You have here two ways to go one is to create everything for learning purpose or use the prebuild docker-images located at docker hub.

If you want to created everything follow the instructions below. If you just want to run it, download ``docker-compose.yml`` and run ``docker-compose up`` from the folder that contains the compose file. And it will download everything for you.

## Creating Images
First build the JAR file for the backend. Use the command ``gradle bootBuildImage`` inside backend folder.

The jar file will be created in: ``/backend/build/libs/firstspringapp-0.0.1-SNAPSHOT.jar``

### Build Docker React and Spring Image
Then we need a docker  for both frontend and backend. 

Navigate into Frontend folder and run ``docker build -t knoph/formdesign-frontend:latest .``

Navigate into Backend folder and run ``docker build -t knoph/formdesign-backend:latest .``

You can test the image with the command: ``docker run -p 80:80 knoph/formdesign-frontend:latest`` and ``docker run -p 8080:8080 knoph/formdesign-backend:latest``

### Build the postgresql image
The backend uses postgresql, so we also need an image containing that one.

Run this to create an image for postgresql: ``docker create -v /var/lib/postgresql/data --name PostgresData alpine``

Then run: ``docker run -p 5432:5432 --name postgres -e POSTGRES_PASSWORD=WR2WPMjrJUoB27 -d --volumes-from PostgresData postgres``

In order to set up a postgresql database for test purpose, and a docker image. You can try and connect your formdesign-spring-docker image to the postgresql db in order to check that it is running.

This step is not crucial for the build process, only for your own test purpose. 

### Check that all images are there 
Run  ``docker image list -a``

You should then see a list of images. And among them ``formdesign-frontend`` ``formdesign-backend`` and ``postgres``

## Creating the database.
To verify that the postgressql server runs. Open now pgadmin4 as an example. And connect to postgresql at localhost. The pssword should be ``WR2WPMjrJUoB27``.

After connected create a new database: ``backendtest`` this is the database spring boot will connect to. When all this is done are you ready to move on.

You can now also stop the container with ``docker container stop postgres``

## Creating docker-compose.yml 
In order to deploy the project as a full docker. We need to combine all the containers to one file. So when we dock it, it runs the frontend, backend and the postgresql server.

The ``docker-compose.yml`` do this for us. 

To build run: ``docker-compose up`` from the folder where docker-compose.yml are located followed by: ``docker-compose up -build``

## Saving the file 

Use these commands to save them to tar.

``docker save -o ./formdesign-frontend.tar formdesign-frontend``

``docker save -o ./formdesign-backend.tar formdesign-backend``

``docker save -o ./postgres.tar postgres``

You can send them to another machine/user and they can load the images with:

``docker load -i ./formdesign-frontend.tar``

``docker load -i ./formdesign-backend.tar``

``docker load -i ./postgres.tar``

To run, use the docker-compose.ym

# TROUBLE WITH STARTUP
Tripple check that the username, and password are the same in the composer file as it is in your application file for spring. The composer file should build the backendtest database and set correct password. 



