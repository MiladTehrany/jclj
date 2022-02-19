# JCLJ
Java Core Library: JDBC

---
>Prerequisites
- Java Programming Language
- SQL
---

### JDBC History and Context
  - History
  
The JDBC API is used to: **C**reate, **R**ead, **U**pdate, **D**elete data,
In relational database using the Java Programming Language.

- Timeline of Event
  - 1997: JDBC 1.1 Add On to JDK 1.0.2
  - 1999: JDBC 2.1 included in JDK 1.2
  - 2001: JDBC 3.0 in JDK 1.4
  - 2006: JDBC 4.0 in Java SE 6
  - 2011: JDBC 4.1 in Java SE 7
  - 2014: JDBC 4.2 integration into Perl
  - 2017: JDBC 4.3 in Java SE 9
  - 2021: JDBC 4.? in Java SE ?

JDBC in the Enterprise

![JDBC](https://user-images.githubusercontent.com/21332301/154792932-64cccc49-ee3b-4ea3-be8a-388184c0d89b.png)

JDBC is for Many Software Domains

![Domains](https://user-images.githubusercontent.com/21332301/154792954-248e852b-5036-451a-8462-45d983191023.png)
- Usage
  - Java 11: OpenJDK or Oracle
  - JDBC 4.3: Many examples work with earlier versions as well
### Setting up your development environment
  - Oracle, SQL Server, MySQL server, and MySQL Workbench
  - Example DB
    - Schema
    
      ![ERD](https://user-images.githubusercontent.com/21332301/154792962-cb1843a8-c8b3-4339-9e19-c17b704f20c4.png)

  - Example code
    - Pom.xml
    - Please download [ojdbc7.jar](https://www.oracle.com/database/technologies/jdbc-drivers-12c-downloads.html) file 
    - Then run into **Command-line**, this command
      >mvn install:install-file -Dfile=./ojdbc7.jar -DgroupId=com.oracle -DartifactId=ojdbc7 -Dversion=12.2.0.1 -Dpackaging=jar
    - [For more information about that](https://mkyong.com/maven/how-to-add-oracle-jdbc-driver-in-your-maven-local-repository/)
    
    - Development Platform
      - Intellij IDEA: [Install](https://www.jetbrains.com/idea/)
      - Eclipse: [Install](https://www.eclipse.org/)
      - Command-line: [Install Apache Maven](https://maven.apache.org/install.html)
### Configuring and connecting JDBC driver
      
- Connection Method
  - DriverManager with Services
  - Class.forName with DriverManager
  - DataSource
    - JNDI
    - Java / Jakarta EE
    - CDI
  - JDBC Follows the Facade Pattern
  
    ![JDBC Pattern](https://user-images.githubusercontent.com/21332301/154792975-5aecbdb6-1f87-481b-b40f-a4ec461b6f86.png)


  - JDBC Interfaces
    
    ![JDBC Interfaces](https://user-images.githubusercontent.com/21332301/154792979-c8e01dfc-b414-4e0a-84dc-6ef6cc2dac6b.png)



### Query, update, and delete data

### Advanced futures

### JDBC RowSets


---

