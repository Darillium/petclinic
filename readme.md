#  PetClinic Demo  Application
![Alt text](Petclinic.png?raw=true "Darillium Pet Clinic")
## Running petclinic locally
```
	git clone https://github.com/Darillium/petclinic.git
	cd petclinic
	./mvnw spring-boot:run
```

You can then access petclinic here: http://localhost:8080/

## Database configuration

In its default configuration, Petclinic uses an in-memory database (HSQLDB) which
gets populated at startup with data. A similar setup is provided for MySql in case a persistent database configuration is needed.
Note that whenever the database type is changed, the data-access.properties file needs to be updated and the mysql-connector-java artifact from the pom.xml needs to be uncommented.

You could start a MySql database with docker:

```
docker run -e MYSQL_ROOT_PASSWORD=petclinic -e MYSQL_DATABASE=petclinic -e MYSQL_USER=pc_user -e MYSQL_PASSWORD=pc_password -p 3306:3306 mysql:5.7.8
```

## DB initialisation.
Pre-Prerequisites:
	You have a mysql client installed on your system.

In your terminal:
```
$cd src/main/resources/db/mysql/
```

Login to mysql as root user:

```
$mysql -h127.0.0.1 -uroot -ppetclinic
```

Once in mysql client prompt:
```
mysql> source schema.sql

mysql> source data.sql
```

If everything went OK, you should be getting a lot of these (or similar) messages - ``Query OK, 1 row affected (0.01 sec)``

At this point, the tables in petclinic database are created and populated and you can run petclinic application with external MySql DB (db is running in a docker container).

*Note:
	Don't forget to specify spring profile `mysql`.*

## Packaging the application as docker image.
You will find a very simple Docker file at the root of this repo, which we are using to "dockerize" our app.

```
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE
ADD ${JAR_FILE} app.jar
EXPOSE 80
ENV JAVA_OPTS=""
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dserver.port=80","-jar","/app.jar"]
```
To be able to create a docker image as part of the build, we are using [dockerfile-maven-plugin from Spotify](link-to-plugin).

If you are not familiar with this plugin, you can follow this simple [spring guide](https://spring.io/guides/gs/spring-boot-docker)

You can build a tagged docker image using the command line like this:

```
$ ./mvnw install dockerfile:build
```

Check that the new docker image was created and you can see it in your local registry.

```
$ docker images
REPOSITORY                        TAG                    IMAGE ID            CREATED             SIZE
barsutka/darillium-petclinic      latest                 57bb93d32b6d        19 hours ago        140MB
```

Now, we are ready to start the newly created image:
```
$ docker run -p 8080:80 --name darillium-petclinic-app --link mysql-standalone:mysql -e SPRING_DATASOURCE_USERNAME=pc_user -e SPRING_DATASOURCE_PASSWORD=pc_password -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/petclinic -e SPRING_PROFILES_ACTIVE=mysql -d barsutka/darillium-petclinic
```

check that the application has started normally by running:
```
$ docker logs darillium-petclinic-app
```

You will get a lot of log messages on your screen, you should see something like that:
```
2018-03-08 16:17:32.079  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 80 (http) with context path ''
2018-03-08 16:17:32.081  INFO 1 --- [           main] o.s.s.petclinic.PetClinicApplication     : Started PetClinicApplication in 5.732 seconds (JVM running for 6.095)
```
The important one is **Tomcat started on port(s): 80 (http) with context path ''**

To check that the application is responding you can use curl command:
```
curl http://localhost:8080/vets.htm
```

Or you can fire up your browser and navigate to http://localhost:8080/.
