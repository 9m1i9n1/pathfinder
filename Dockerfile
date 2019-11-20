FROM java:8
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
VOLUME /tmp
ADD target/pathfinder-0.0.1-SNAPSHOT.war pathfinder.war
ENTRYPOINT ["java","-jar", "/pathfinder.war"]