# Create Backend Docker file
This project uses React as a Frontend and Springboot as a backend, with the help of postgresql. In order to create a docker file, we need to first setup the images needed. For then to create a docker file.

## Creating Images
First build the JAR file for the backend. Use the command ``gradle bootBuildImage`` inside backend folder.

The jar file will be created in: ``/backend/build/libs/firstspringapp-0.0.1-SNAPSHOT.jar``

### Build Docker React and Spring Image
Then we need a docker image contain both front and back end. From the folder contain Docker file run ``docker build -t formdesign-docker .``

You can test the image with the command: ``docker run -p 80:80 formdesign-spring-docker``

### Build the postgresql image
The backend uses postgresql, so we also need an image containing that one.

Run this to create an image for postgresql: ``docker create -v /var/lib/postgresql/data --name PostgresData alpine``

Then run: ``docker run -p 5432:5432 --name postgres -e POSTGRES_PASSWORD=WR2WPMjrJUoB27 -d --volumes-from PostgresData postgres``

In order to set up a postgresql database for test purpose, and a docker image.

### Check that all images are there 
Run  ``docker image list -a``

You should then see a list of images. And among them ``formdesign-spring-boot-docker`` and ``postgres``

## Creating the database.
To verify that the postgressql server runs. Open now pgadmin4 as an example. And connect to postgresql at localhost. The pssword should be ``WR2WPMjrJUoB27``.

After connected create a new database: ``backendtest`` this is the database spring boot will connect to. When all this is done are you ready to move on.

You can now also stop the container with ``docker container stop postgres``

## Creating docker-compose.yml 
In order to deplay the project as a full docker. We need to combine all the containers to one file. So when we dock it, it runs the frontend, backend and the postgresql server.

The ``docker-compose.yml`` do this for us. 

To build run: ``docker-compose up`` from the folder where docker-compose.yml are located followed by: ``docker-compose up -build``

# TROUBLE WITH STARTUP
If you had to delte postgres inorder to build the compose file, the ``backendtest`` database was deleted. You need to login in to the postgres database
and create it before you can run the conatiner. You will not be able to run it, since they wil say backendtest is missing.



