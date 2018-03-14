# Petclinic Database initialization in docker container

If you want to run Petclinic database initialization in a docker container this place is for you.

## Build the docker image
To build the docker image that will run the database initialization task just invoke the build-image.sh script from the local directory:
```
./build-image.sh
```

To see the content of the script [build-image.sh](./build-image.sh) - follow the script.

After successful run of this script you should see the following output:
```
Successfully tagged mysql-db-migration:latest
```
## Running the db-initialization container
before running the db-initialization container, make sure that the mysql container with Petclinic database is up and running.
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
afd46fae5ef6        mysql:5.7.20        "docker-entrypoint.s…"   22 hours ago        Up 9 seconds        0.0.0.0:3306->3306/tcp   mysql-standalone
```

Now we are ready to run the db-init container.
