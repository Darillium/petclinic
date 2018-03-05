#  PetClinic Demo  Application

## Running petclinic locally
```
	git clone https://github.com/Darillium/petclinic.git
	cd spring-petclinic
	./mvnw spring-boot:run
```

You can then access petclinic here: http://localhost:8080/

## Database configuration

In its default configuration, Petclinic uses an in-memory database (HSQLDB) which
gets populated at startup with data. A similar setup is provided for MySql in case a persistent database configuration is needed.
Note that whenever the database type is changed, the data-access.properties file needs to be updated and the mysql-connector-java artifact from the pom.xml needs to be uncommented.

You could start a MySql database with docker:

```
docker run -e MYSQL_ROOT_PASSWORD=petclinic -e MYSQL_DATABASE=petclinic -p 3306:3306 mysql:5.7.8
```



