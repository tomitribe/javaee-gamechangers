#!/bin/bash

for n in */; do
 n="$(basename $n)"
cat > $n/pom.xml <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>org.superbiz</groupId>
  <artifactId>$n</artifactId>
  <packaging>jar</packaging>
  <version>1.1.0-SNAPSHOT</version>
  <name>$n</name>
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
  <build>
    <defaultGoal>install</defaultGoal>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.1</version>
        <configuration>
          <source>1.7</source>
          <target>1.7</target>
        </configuration>
      </plugin>
    </plugins>
  </build>
  <repositories>
    <repository>
      <id>apache-m2-snapshot</id>
      <name>Apache Snapshot Repository</name>
      <url>https://repository.apache.org/content/groups/snapshots</url>
    </repository>
  </repositories>
  <dependencies>
    <dependency>
      <groupId>org.apache.openejb</groupId>
      <artifactId>javaee-api</artifactId>
      <version>7.0-SNAPSHOT</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>
    <!-- The <scope>test</scope> guarantees that none of your runtime code 
      is dependent on any OpenEJB classes. -->
    <dependency>
      <groupId>org.apache.openejb</groupId>
      <artifactId>openejb-core</artifactId>
      <version>5.0.0-SNAPSHOT</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <!-- This section allows you to configure where to publish libraries for
    sharing. It is not required and may be deleted. For more information see:
    http://maven.apache.org/plugins/maven-deploy-plugin/ -->
  <distributionManagement>
    <repository>
      <id>localhost</id>
      <url>file://\${basedir}/target/repo/</url>
    </repository>
    <snapshotRepository>
      <id>localhost</id>
      <url>file://\${basedir}/target/snapshot-repo/</url>
    </snapshotRepository>
  </distributionManagement>

</project>
EOF
done
