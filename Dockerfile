FROM openjdk:8-jdk-slim
VOLUME /tmp
ADD target/pathfinder-0.0.1-SNAPSHOT.war pathfinder.war
ENTRYPOINT ["java","-jar", "/pathfinder.war"]